{ inputs, self, user, hyprland, home-manager, config, pkgs, ... }:
let
  user = user;
in

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = true;
    hidpi = true;
    reccommendedEnvironment = true;
  };

}
