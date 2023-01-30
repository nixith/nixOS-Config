#!/bin/nu

# get ssh id
let IP = (sudo virsh net-dhcp-leases default 52:54:00:93:0e:e6 | from ssv --aligned-columns | get "IP address".1 | split row "/" | get 0)
# format for ssh
let sshString = $"ryan@($IP)"

let scpDestination = $"($sshString):/home/ryan/nixOS-Config/"


scp -r /home/ryans/Documents/nix/nixOS-Config/* $scpDestination
