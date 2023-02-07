#!/usr/bin/env bash

export EDITOR="helix"
export SHELL="fish"
export XDG_CURRENT_DESKTOP="Hyprland"
export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="Hyprland"
  
export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_QPA_PLATFORM="wayland,xcb"
export QT_QAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME="qt5ct"

export GBM_BACKEND="nvidia-drm"
export __GLX_VENDOR_LIBRARY_NAME="nvidia"
export LIBVA_DRIVER_NAME="nvidia"
export WLR_NO_HARDWARE_CURSORS=1
export __GL_VRR_ALLOWED=0

export SHELL="/usr/bin/env fish"
export EDITOR="hx"

sleep 1 & Hyprland