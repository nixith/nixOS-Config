{ pkgs, ... }:
{
  home.packages = with pkgs;[
    jq
    socat
  ];
  programs.eww = {
    enable = true;
    configDir = ./ewwConf;
  };
}
