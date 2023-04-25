{
  pkgs,
  home-manager,
  ...
}: {
  home.packages = with pkgs; [
    qt6.full
    qt6.qtwayland
    qt6.wrapQtAppsHook
    qt5.qtwayland
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtx11extras
  ];
  qt = {
    enable = true;
    platformTheme = "gtk";
    #style = {
    #  package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    #  name = "kvantum";
    #};
  };

  #  home.sessionVariables = {
  #    QT_QPA_PLATFORMTHEME = "qt5ct";
  #    QT_STYLE_OVERRIDE = "kvantum";
  #  };

  #  xdg.dataFile = {
  #    "./kvantumThemes/Catppuccin-Mocha-Lavender" = {
  #      source = ./kvantumThemes/Catppuccin-Mocha-Lavender;
  #    };
  #  };
  #  xdg.configFile = {
  #    "./qt5ct/catppuccin.conf" = {
  #      source = ./qt5ct/catppuccin.conf;
  #      target = "qt5ct/catppuccin.conf";
  #    };
  #  };
}
