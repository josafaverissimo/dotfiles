from enum import Enum
import os


class ArgEnum(Enum):
    COMMAND = 0


class ToggleOpacitySettingEnum(Enum):
    OPAQUE = 1.0
    ACTIVE_TRANSLUCENT = 0.8
    INACTIVE_TRANSLUCENT = 0.7
