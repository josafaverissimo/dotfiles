#!/usr/bin/env python3

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

    logger.info(f"Running command {command_name}")

    command()


if __name__ == "__main__":
    main()
