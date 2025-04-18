from typing import Callable, cast
import re

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
            process = run("hyprctl getoption decoration:active_opacity")

            if process.error:
                logger.error(process.error)

                return

            assert process.value is not None

            re_match = re.match(r"float: (\d*\.\d{2})", process.value)

            if not re_match:
                logger.error(
                    f"Failed to get opacity float from stdout: {process.value}"
                )

                return

            current_opacity: str = re_match.group(1)

            return float(current_opacity)

        def set_opacity(active: float, inactive: float):
            run(f'hyprctl keyword decoration:active_opacity "{active:.1f}"')
            run(f'hyprctl keyword decoration:inactive_opacity "{inactive:.1f}"')

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
                return False

            return True

        if is_alive():
            kill()

            return

        resurrect()
