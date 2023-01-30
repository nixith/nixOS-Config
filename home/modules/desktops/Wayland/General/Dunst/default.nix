{ pkgs, ... }:
{ 
  home.packages = with pkgs; [
    libnotify
  ];
  services.dunst = {
    enable = true;
    configFile = ./dunstrc;
  };
}