{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}:
{
  gtk = {
    enable = true;

    # cursorTheme = let pkg = pkgs.catppuccin-cursors.mochaDark;
    # in {
    #   name = "catppuccin-mocha-dark-cursors";
    #   package = pkg;
    # };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
