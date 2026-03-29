inputs:
{ pkgs, ... }:
let

  pins = import ../../npins;

  ff-module =
    let
      ff-package = pkgs.wrapFirefox (pkgs.callPackage "${pins.glide-browser}/package.nix" { }) {
        pname = "glide-browser";
      };
    in
    import ./Gui/firefox { inherit pkgs ff-package; };

in

{

  imports = [
    ./CLI/Tools.nix
    #./editors/neovim
    ./CLI/btop
    # nvim
    ./editors/neovim
    ./Gui/default.nix

    # ./Gui/firefox
    ff-module
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
    ./desktops/Wayland/General/fnott
    # niri-wm
    ./desktops/Wayland/niri
    ./desktops/Wayland/General/vicinae
    # anyrun-module
    ./services/stylix
    ./services/music/default.nix
  ];
}
