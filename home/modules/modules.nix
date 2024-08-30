self:
{ ... }:
let

  realSelf = self.self;
  inherit (realSelf.inputs) nixd;
  inherit (realSelf.inputs) hyprland;
  inherit (realSelf.inputs) niri;
  inherit (realSelf.inputs) anyrun;

  nvim = import ./editors/neovim nixd;
  anyrun-module = import ./desktops/Wayland/General/anyrun anyrun;
  hyprland-wm = import ./desktops/Wayland/hyprland hyprland;
  niri-wm = import ./desktops/Wayland/niri niri;
in {
  imports = [
    ./CLI/Tools.nix
    ./CLI/btop
    nvim
    ./Gui/default.nix
    ./shells/Fish
    ./services/syncthing
    ./shells/shellApps/Starship
    ./Terminals/foot
    ./Terminals/rio
    hyprland-wm
    niri-wm
    anyrun-module
  ];
}
