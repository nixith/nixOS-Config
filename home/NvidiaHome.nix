{ config, lib, home-manager, inputs, computer, ... }: {
  imports = if computer == "Galaxia" then
    [ ./modules/desktops/Wayland/hyprland/NvidiaHyprland.nix ]
  else
    [ ];
}
