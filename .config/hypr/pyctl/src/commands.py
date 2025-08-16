from functools import reduce
from typing import Callable, cast
import json

from src.constants import MAX_WORKSPACES, MIN_WORKSPACES
from src.types import OpacityDict, WindowInfoDict
from src.utils import Result, run, CustomLogger
from src.enums import ToggleOpacitySettingEnum
from src.constants import WALLPAPERS_DIR
from random import randint

logger = CustomLogger.get_logger(__name__)


class Commands:
    def __init__(self):
        self.__available_commands = {
            command for command in dir(self) if command[0] != "_"
        }

    def get(self, command: str):
        if command not in self.__available_commands:
            return

        return cast(Callable[[], None], getattr(self, command))

    @staticmethod
    def toggle_opacity():
        def get_current_opacity() -> float | None:
            process = run("hyprctl getoption decoration:active_opacity -j")

            if process.error:
                logger.error(process.error)

                return

            assert process.value is not None

            try:
                opacity_dict: OpacityDict = json.loads(process.value)

            except json.JSONDecodeError:
                logger.error(f"Failed to parse opacity json: {process.value}")

                return

            return opacity_dict["float"]

        def set_opacity(active: float, inactive: float):
            run(f'hyprctl keyword decoration:active_opacity "{active:.2f}"')
            run(f'hyprctl keyword decoration:inactive_opacity "{inactive:.2f}"')

        current_opacity = get_current_opacity()

        if not current_opacity:
            return

        if current_opacity == ToggleOpacitySettingEnum.OPAQUE.value:
            logger.info("Setting opacity")

            set_opacity(
                ToggleOpacitySettingEnum.ACTIVE_TRANSLUCENT.value,
                ToggleOpacitySettingEnum.INACTIVE_TRANSLUCENT.value,
            )

            return

        logger.info("Removing opacity")

        set_opacity(
            ToggleOpacitySettingEnum.OPAQUE.value,
            ToggleOpacitySettingEnum.OPAQUE.value,
        )

    @staticmethod
    def toggle_hypridle():
        def kill() -> bool:
            logger.info("Killing hypridle")

            process = run("pkill hypridle")

            if process.error:
                logger.error(process.error)

                return False

            return True

        def resurrect() -> bool:
            logger.info("Resurrecting hypridle")

            process = run("hyprctl dispatch exec hypridle")

            if process.error:
                logger.error(process.error)

                return False

            return True

        def is_alive() -> bool:
            process = run("pgrep hypridle")

            if process.error:
                logger.error(process.error)

                return False

            return True

        if is_alive():
            kill()

            return

        resurrect()

    @staticmethod
    def __change_worksace(workspace: int):
        process = run(f"hyprctl dispatch workspace {workspace}")

        if process.error:
            logger.error(process.error)

            return

    @staticmethod
    def __get_current_workspace():
        process = run("hyprctl activeworkspace -j")

        if process.error:
            logger.error(process.error)

            return

        assert process.value is not None

        return cast(int, json.loads(process.value)["id"])

    def __get_next_workspace(self):
        current_workspace = self.__get_current_workspace()

        if not current_workspace:
            return

        next_workspace = current_workspace + 1
        max_workspace = 10

        if next_workspace > max_workspace:
            next_workspace = 1

        return next_workspace

    def __get_previous_workspace(self) -> int | None:
        current_workspace = self.__get_current_workspace()

        if not current_workspace:
            return

        previous_workspace = current_workspace - 1
        min_workspace = MIN_WORKSPACES

        if previous_workspace < min_workspace:
            previous_workspace = MAX_WORKSPACES

        return previous_workspace

    @staticmethod
    def __send_window_to_workspace(window: str, workspace: int):
        run(f"hyprctl dispatch movetoworkspace {workspace},{window}")

    def back_workspace(self):
        previous_workspace = self.__get_previous_workspace()

        if not previous_workspace:
            return

        self.__change_worksace(previous_workspace)

    def next_workspace(self):
        next_workspace = self.__get_next_workspace()

        if not next_workspace:
            return

        self.__change_worksace(next_workspace)

    def send_focused_to_next_workspace(self):
        next_workspace = self.__get_next_workspace()

        if not next_workspace:
            return

        self.__send_window_to_workspace("activewindow", next_workspace)

    def send_focused_to_previous_workspace(self):
        previous_workspace = self.__get_previous_workspace()

        if not previous_workspace:
            return

        self.__send_window_to_workspace("activewindow", previous_workspace)

    @staticmethod
    def select_hypr_client():
        windows = cast(
            list[WindowInfoDict],
            json.loads(cast(str, run("hyprctl clients -j").value)),
        )

        windows_by_initial_title = {
            str(window["initialTitle"]): window for window in windows
        }

        windows_titles_string = "\n".join(
            map(lambda window: window["initialTitle"], windows)
        )

        selected_window_initial_title = (run(
            "wofi --dmenu", input_text=windows_titles_string
        ).value or "").replace("\n", "")

        window_address = windows_by_initial_title.get(
            selected_window_initial_title,
            {}
        ).get("address")

        if not window_address:
            return

        run(f"hyprctl dispatch focuswindow address:{window_address}")

    def __get_active_wallpaper_by_monitor(self) -> Result[dict[str, str] | None, str | None]:
        process = run("hyprctl hyprpaper listactive")

        if process.error:
            return Result(None, process.error)

        assert process.value is not None

        wallpapers = process.value.split('\n')

        if not wallpapers[-1]:
            wallpapers = wallpapers[:-1]

        def wallpapers_to_dict(wallpapers_by_monitor, raw_active_wallpaper):
            active_wallpaper = raw_active_wallpaper.replace(' ', '').split('=')

            if len(active_wallpaper) < 2:
                return

            [monitor, wallpaper] = active_wallpaper

            wallpapers_by_monitor[monitor] = wallpaper

            return wallpapers_by_monitor


        wallpapers_by_monitor = reduce(wallpapers_to_dict, wallpapers, {})

        return Result(wallpapers_by_monitor, None)

    def __get_available_monitors(self) -> Result[set[str] | None, str | None]:
        process = run('hyprctl monitors -j')

        if process.error:
            return Result(None, process.error)

        assert process.value is not None

        def get_monitor_name(monitor_data):
            return monitor_data['name']

        monitors = map(get_monitor_name, json.loads(process.value))

        return Result(set(monitors), None)

    def randomizer_wallpaper(self):
        if not WALLPAPERS_DIR.exists() and not WALLPAPERS_DIR.is_dir():
            return

        available_monitors = self.__get_available_monitors()

        if available_monitors.error:
            logger.error(available_monitors.error)

            return

        assert available_monitors.value is not None

        active_wallpaper_by_monitor = self.__get_active_wallpaper_by_monitor()

        files = [file for file in WALLPAPERS_DIR.iterdir() if file.is_file()]

        if active_wallpaper_by_monitor.error:
            logger.error(active_wallpaper_by_monitor.error)

        if active_wallpaper_by_monitor.value:
            for wallpaper in active_wallpaper_by_monitor.value.values():
                files = list(filter(lambda file: wallpaper not in file.parts, files))

        for monitor in available_monitors.value:
            random_index = randint(0, len(files) - 1)
            random_wallpaper = str(files[random_index].resolve())

            files.pop(random_index)

            run(f'hyprctl hyprpaper reload {monitor},"{random_wallpaper}"')
            


