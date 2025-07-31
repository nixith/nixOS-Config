{ inputs, ... }:
let
  #inherit (inputs) nixd;
  # inherit (inputs) hyprland;
  # # inherit (inputs) niri;
  # inherit (inputs) anyrun;
  # inherit (inputs) nixivim;
  # inherit (inputs) stylix;

in
#nvim = import ./editors/neovim nixd;
# anyrun-module = import ./desktops/Wayland/General/anyrun;
# hyprland-wm = import ./desktops/Wayland/hyprland hyprland;
# niri-wm = import ./desktops/Wayland/niri niri;
# nvim = import ./editors/neovim;
# stylix-module = import ./services/stylix;
{
  imports = [
    ./CLI/Tools.nix
    #./editors/neovim
    ./CLI/btop
    # nvim
    ./editors/neovim
    ./Gui/default.nix
    ./Gui/mpv
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
    ./desktops/Wayland/General/swayOSD
    ./desktops/Wayland/General/swayidle
    ./desktops/Wayland/General/swaync
    # hyprland-wm
    # niri-wm
    ./desktops/Wayland/niri
    # anyrun-module
    ./services/stylix
  ];
}
