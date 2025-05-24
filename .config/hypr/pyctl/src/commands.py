from typing import Callable, cast
import re
import json

from src.constants import MAX_WORKSPACES, MIN_WORKSPACES
from src.types import OpacityDict
from src.utils import run, CustomLogger
from src.enums import ToggleOpacitySettingEnum

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
