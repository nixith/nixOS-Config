{ pkgs, ... }:
{
  home.packages = with pkgs; [ oranchelo-icon-theme ];
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;

    extraConfig = {
      modi = "run,drun,calc";
      icon-theme = "Papirus";
      show-icons = true;
      terminal = "wezterm";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };

    theme = ./Themes/catppuccin-mocha.rasi;
    font = "JetBrains Mono";

    plugins = with pkgs; [
      rofi-calc
      rofimoji
    ];
  };
}
