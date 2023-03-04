{ config, lib, home-manager, computer, ... }:
{
  imports = (if computer == "Galaxia" then [
    ./modules/desktops/Wayland/hyprland/NvidiaHyprland.nix
  ]
  else []);

}
