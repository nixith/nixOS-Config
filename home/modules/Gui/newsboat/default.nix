{ config, lib, pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    extraConfig = builtins.tostring (builtins.readFile (./dark));
  };
}
