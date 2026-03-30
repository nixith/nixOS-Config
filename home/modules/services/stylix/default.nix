{ pkgs, ... }:
{
  stylix = {
    enable = true;
    targets.firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "stylix" ];
      #colorTheme.enable = true;
    };
    iconTheme = {
      enable = true;
      dark = "Adwaita";
      light = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    targets.gtk = {
      flatpakSupport.enable = true;
    };

    # targets.qt = {
    #   platform = "gnome";
    #   # style = "adwaita-dark";
    # };
  };
}
