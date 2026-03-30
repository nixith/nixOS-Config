{ pkgs, ... }:
{
  stylix = {
    enable = true;
    targets.firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "stylix" ];
      #colorTheme.enable = true;
    };

    # targets.qt = {
    #   platform = "gnome";
    #   # style = "adwaita-dark";
    # };
  };
}
