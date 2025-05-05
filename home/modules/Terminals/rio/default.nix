{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.nixith.rio;
in
{
  options = {
    nixith.rio.enable = lib.mkEnableOption "enable the rio terminal";
  };
  config = lib.mkIf cfg.enable {
    programs.rio = {
      enable = true;
      #package = rio.packages.${pkgs.system}.rio;
      settings = {
        fonts = {
          size = 12;
          family = "JuliaMono";
        };
        colors = {
          "background" = "#1e1e2e";
          "black" = "#45475a";
          "blue" = "#89b4fa";
          "cursor" = "#f5e0dc";
          "cyan" = "#94e2d5";
          "dim-black" = "#45475a";
          "dim-blue" = "#89b4fa";
          "dim-cyan" = "#94e2d5";
          "dim-foreground" = "#cdd6f4";
          "dim-green" = "#a6e3a1";
          "dim-magenta" = "#f5c2e7";
          "dim-red" = "#f38ba8";
          "dim-white" = "#bac2de";
          "dim-yellow" = "#f9e2af";
          "foreground" = "#cdd6f4";
          "green" = "#a6e3a1";
          "light-black" = "#585b70";
          "light-blue" = "#89b4fa";
          "light-cyan" = "#94e2d5";
          "light-foreground" = "#cdd6f4";
          "light-green" = "#a6e3a1";
          "light-magenta" = "#f5c2e7";
          "light-red" = "#f38ba8";
          "light-white" = "#a6adc8";
          "light-yellow" = "#f9e2af";
          "magenta" = "#f5c2e7";
          "red" = "#f38ba8";
          "selection-background" = "#f5e0dc";
          "selection-foreground" = "#1e1e2e";
          "tabs" = "#1e1e2e";
          "tabs-active" = "#b4befe";
          "white" = "#bac2de";
          "yellow" = "#f9e2af";
        };

      };
    };
  };
}
