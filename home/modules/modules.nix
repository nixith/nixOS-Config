self:
{ ... }:
let
  realSelf = self.self;
  inherit (realSelf.inputs) nixd;
  inherit (realSelf.inputs) hyprland;
  inherit (realSelf.inputs) anyrun;
  nvim = import ./editors/neovim nixd;
  hyprland-wm = import ./desktops/Wayland/hyprland { inherit hyprland anyrun; };
in {
  imports = [
    ./CLI/Tools.nix
    ./CLI/btop
    nvim
    ./Gui/default.nix
    ./shells/Fish
    ./shells/shellApps/Starship
    hyprland-wm
  ];
}
