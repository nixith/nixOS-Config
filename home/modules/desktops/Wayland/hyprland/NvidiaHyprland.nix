{ inputs, self, user, nvidia, ... }:
{
  wayland.windowManager.hyprland.hyprland = {
    nvidiaPatches = true;
  };
  import = [ ./Hyprland.nix ];

}
