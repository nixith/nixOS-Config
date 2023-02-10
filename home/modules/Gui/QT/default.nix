{ pkgs, home-manager, ... }:
{
  home.packages = with pkgs;
    [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
  qt = {
    enable = true;
    style = {
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
      name = "kvantum";
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  xdg.dataFile = {
    "./kvantumThemes/Catppuccin-Mocha-Lavender" = {
      source = ./kvantumThemes/Catppuccin-Mocha-Lavender;
    };
  };
  xdg.configFile = {
    "./qt5ct/catppuccin.conf" = {
      source = ./qt5ct/catppuccin.conf;
      target = "qt5ct/catppuccin.conf";
    };
  };
}
