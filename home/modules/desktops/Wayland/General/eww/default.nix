{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jaq
    socat
    lm_sensors
  ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./ewwConf;
  };
}
