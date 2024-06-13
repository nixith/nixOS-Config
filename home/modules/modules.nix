{ lib, config, ... }:
let cfg = config.nixith;
in {
  imports = [
    ./CLI/Tools.nix
    ./CLI/btop
    ./Gui/default.nix
    ./shells/Fish
    ./editors/neovim
    ./shells/shellApps/Starship
    ./desktops/Wayland/hyprland
  ];
}
