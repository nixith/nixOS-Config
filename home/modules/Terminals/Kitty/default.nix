{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Lilex Nerd Font Regular";
      size = 12;
    };
    settings = {
      background_opacity = "0.4";
      background_tint = "1";
      shell = "fish --login --interactive";
    };
    extraConfig = builtins.readFile ./catppuccin-mocha.conf;
  };
}
