from typing import TypeVar, NamedTuple, Generic
import logging
import subprocess
import shlex

T = TypeVar("T")
K = TypeVar("K")


class Result(NamedTuple, Generic[T, K]):
    value: T
    error: K


class CustomLogger:
    __instances: dict[str, logging.Logger] = {}

    @classmethod
    def get_logger(cls, name: str):
        if cls.__instances.get(name):
            return cls.__instances[name]

        formater = logging.Formatter(
            "[%(asctime)s - %(name)s - line %(lineno)s]: "
            + "%(levelname)s - %(message)s"
        )

        handler = logging.StreamHandler()
        handler.setFormatter(formater)
        handler.setLevel(logging.INFO)

        logger = logging.getLogger(name)
        logger.setLevel(logging.INFO)
        logger.addHandler(handler)

        cls.__instances[name] = logger

        return cls.__instances[name]


def run(
    cmd: str,
    /,
    input_text: str | None = None,
) -> Result[str | None, str | None]:
    try:
        process = subprocess.run(
            shlex.split(cmd),
            check=True,
            capture_output=True,
            text=True,
            input=input_text,
        )

        return Result(process.stdout, None)

    except FileNotFoundError:
        return Result(None, "Command not found")

    except subprocess.CalledProcessError as error:
        return Result(None, f"Failed to run {cmd} - {error.stderr}")
