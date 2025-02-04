stylix:
{ pkgs, ... }: {
  stylix = {
    enable = true;
    targets.firefox.firefoxGnomeTheme.enable = true;
    iconTheme = {
      enable = true;
      dark = "Everforest-Dark";
      light = "Everforest-Light";
      package = pkgs.everforest-gtk-theme;
    };
  };
}
