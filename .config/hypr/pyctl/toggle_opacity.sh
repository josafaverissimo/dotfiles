#!/bin/bash

current_opacity=$(hyprctl getoption decoration:inactive_opacity | rg --pcre2 "(?<=float:\s)\d\.\d" -o)

opaque=1.0
active_translucent=0.95
inactive_translucent=0.9

echo $current_opacity
echo $opaque

if [[ "$current_opacity" == "$opaque" ]]; then
  hyprctl keyword decoration:inactive_opacity "$inactive_translucent"
  hyprctl keyword decoration:active_opacity "$active_translucent"
else
  hyprctl keyword decoration:inactive_opacity "$opaque"
  hyprctl keyword decoration:active_opacity "$opaque"
fi
