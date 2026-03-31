{ pkgs, ... }:
{
  stylix = {
    enable = true;
    targets.gtk = {
      flatpakSupport.enable = true;
    };
    targets.firefox = {
      enable = true;
      firefoxGnomeTheme.enable = true;
      profileNames = [ "stylix" ];
      #colorTheme.enable = true;
    };
    targets.gtk.enable = false;
    targets.ghostty.enable = false;
    targets.vicinae.enable = false;
    targets.waybar = {
      colors.enable = false;
      opacity.enable = true;
    };
    # targets.qt = {
    #   platform = "gnome";
    #   # style = "adwaita-dark";
    # };
  };
}
