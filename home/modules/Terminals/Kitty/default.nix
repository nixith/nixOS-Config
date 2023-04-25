{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {name = "JetBrians Mono";};
    settings = {
      background_opacity = "0.4";
      background_tint = "1";
      shell = "fish --login --interactive";
    };
    extraConfig = builtins.readFile ./catppuccin-mocha.conf;
  };
}
