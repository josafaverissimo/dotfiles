from enum import Enum
import os


class ArgEnum(Enum):
    COMMAND = 0


class ToggleOpacitySettingEnum(Enum):
    OPAQUE = 1.0
    ACTIVE_TRANSLUCENT = float(os.getenv("HYPR_ACTIVE_OPACITY", "0.8"))
    INACTIVE_TRANSLUCENT = float(os.getenv("HYPR_INACTIVE_OPACITY", "0.7"))
