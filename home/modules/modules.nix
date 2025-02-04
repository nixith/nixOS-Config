{ inputs, ... }:
let
  #inherit (inputs) nixd;
  inherit (inputs) hyprland;
  inherit (inputs) niri;
  inherit (inputs) anyrun;
  inherit (inputs) nixivim;
  inherit (inputs) stylix;

  #nvim = import ./editors/neovim nixd;
  anyrun-module = import ./desktops/Wayland/General/anyrun anyrun;
  hyprland-wm = import ./desktops/Wayland/hyprland hyprland;
  niri-wm = import ./desktops/Wayland/niri niri;
  nvim = import ./editors/neovim nixivim;
  stylix-module = import ./services/stylix stylix;
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
    ./Terminals/ghostty
    ./desktops/Wayland/river
    ./desktops/Wayland/General/kanshi
    ./desktops/Wayland/General/Waybar
    ./desktops/Wayland/General/fuzzel
    hyprland-wm
    niri-wm
    anyrun-module
    stylix-module
  ];
}
