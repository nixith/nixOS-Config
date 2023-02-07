{ config, lib, home-manager, ... }:
{
  imports = [
    ./modules/desktops/Wayland/hyprland/NvidiaHyprland.nix
  ];
}
