{ inputs, ... }:
let
  inherit (inputs) nixd;
  inherit (inputs) hyprland;
  inherit (inputs) niri;
  inherit (inputs) anyrun;
  inherit (inputs) nixivim;

  #nvim = import ./editors/neovim nixd;
  anyrun-module = import ./desktops/Wayland/General/anyrun anyrun;
  hyprland-wm = import ./desktops/Wayland/hyprland hyprland;
  niri-wm = import ./desktops/Wayland/niri niri;
  nvim = import ./editors/neovim nixivim;
in {
  imports = [
    ./CLI/Tools.nix
    #./editors/neovim
    ./CLI/btop
    nvim
    ./Gui/default.nix
    ./shells/Fish
    ./services/syncthing
    ./shells/shellApps/Starship
    ./Terminals/foot
    ./Terminals/rio
    ./desktops/Wayland/river
    ./desktops/Wayland/General/kanshi
    hyprland-wm
    niri-wm
    anyrun-module
  ];
}
