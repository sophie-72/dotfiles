#!/bin/bash

hyprctl devices -j |
  jq -r '.keyboards[] | .active_keymap' |
  tail -n 1 |
  awk -F'\\(' '{ if (NF>1) print substr($0, 1, 2) "-" substr($2, 1, 2)}' |
  tr 'A-Z' 'a-z'
