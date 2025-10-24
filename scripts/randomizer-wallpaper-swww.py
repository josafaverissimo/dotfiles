#!/usr/bin/env python3

from pathlib import Path
from random import randint
import subprocess

wallpapers_dir = Path("~/Pictures/wallpapers/current").expanduser()

if not wallpapers_dir.exists() or not wallpapers_dir.is_dir():
    print('wallpapers path not found')

    exit(0)

files = [file for file in wallpapers_dir.iterdir() if file.is_file()]

result = subprocess.run("swww query", shell=True, capture_output=True, text=True)

monitors = result.stdout.split('\n')

for monitor in monitors:
    if monitor == '':
        continue

    monitor_data, scale_data, current_wallpaper_data = monitor[2:].split(',')

    monitor_name = monitor_data.split(':')[0]

    random_file = files[randint(0, len(files) - 1)]

    subprocess.run(
        f"swww img {str(random_file)} -o {monitor_name} -t any --transition-duration 2 "
        + "--transition-fps 165 --resize crop", shell=True
    )
