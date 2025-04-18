#!/usr/bin/env python3

from typing import Callable

from sys import argv

from src.commands import Commands
from src.utils import CustomLogger
from src.enums import ArgEnum


def main():
    logger = CustomLogger.get_logger(__name__)

    args = argv[1:]

    if len(args) == 0:
        logger.warning("Arg list is empty")

        return

    commands = Commands()
    command_name = args[ArgEnum.COMMAND.value]
    command = commands.get(command_name)

    if not command:
        logger.warning(f"Command {command_name} not found")

        return

    command()


if __name__ == "__main__":
    main()
