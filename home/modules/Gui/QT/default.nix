{pkgs, ...}: {
  home.packages = with pkgs; [
    qt6.qtwayland
  ];
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt6;
      name = "adwaita-dark";
    };
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
