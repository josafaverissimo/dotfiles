from enum import Enum


class ArgEnum(Enum):
    COMMAND = 0


class ToggleOpacitySettingEnum(Enum):
    OPAQUE = 1.0
    ACTIVE_TRANSLUCENT = 0.95
    INACTIVE_TRANSLUCENT = 0.9
