{ config, lib, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Lilex Nerd Font Regular";
      size = 10;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      background_opacity = "0.4";
      background_tint = "1";
      shell = "fish --login --interactive";
    };
  };
}
