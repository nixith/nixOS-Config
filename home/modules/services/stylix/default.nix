{ pkgs, ... }: {
  stylix = {
    enable = true;
    targets.firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "test" ];
    };
    iconTheme = {
      enable = true;
      dark = "Everforest-Dark";
      light = "Everforest-Light";
      package = pkgs.everforest-gtk-theme;
    };
    targets.qt = {
      platform = "gnome";
      # style = "adwaita-dark";
    };
  };
}
