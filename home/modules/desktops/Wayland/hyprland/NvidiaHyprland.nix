{ inputs, self, user, nvidia, ... }:
{
  wayland.windowManager.hyprland = {
    nvidiaPatches = true;
  };
  imports = [ ./default.nix ];

}
