#!/usr/bin/env nu
let MONITOR_ID_TABLE = (hyprctl monitors -j | from json | select name id | transpose -r)
 let workspacesStats = hyprctl workspaces -j | from json | 
   each { |workspace| { ($workspace.id | into string): {windows: $workspace.windows monitor: ($MONITOR_ID_TABLE | get $workspace.monitor).0} }}  |
   reduce {|it, acc| $acc | merge $it }
 
seq 1 10  | into record | items {|key, value| {"id": $value stats: ($workspacesStats | get -i $"($value)")}} | default 0 stats  | to json


