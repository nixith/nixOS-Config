{ pkgs, ... }:
{
  stylix = {
    enable = true;
    targets.firefox = {
      firefoxGnomeTheme.enable = true;
    };
    iconTheme = {
      enable = true;
      dark = "Adwaita";
      light = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    # targets.qt = {
    #   platform = "gnome";
    #   # style = "adwaita-dark";
    # };
  };
}
