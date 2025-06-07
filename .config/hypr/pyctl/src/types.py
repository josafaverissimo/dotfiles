from typing import TypedDict, Literal, Tuple


class OpacityDict(TypedDict):
    option: Literal["decoration:active_opacity", "decoration:active_opacity"]
    float: float
    set: bool


class WorkspaceDict(TypedDict):
    id: int
    name: str


class WindowInfoDict(TypedDict):
    address: str
    mapped: bool
    hidden: bool
    at: Tuple[int, int]
    size: Tuple[int, int]
    workspace: WorkspaceDict
    floating: bool
    pseudo: bool
    monitor: int
    title: str
    initialClass: str
    initialTitle: str
    pid: int
    xwayland: bool
    pinned: bool
    fullscreen: int
    fullscreenClient: int
    swallowing: str
    focusHistoryID: int
    inhibitingIdle: bool
    xdgTag: str
    xdgDescription: str
