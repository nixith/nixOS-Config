{ config, lib, pkgs, user, inputs, ... }:


{
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };

  gtk = {
    enable = true;

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
    };

    theme = {
      name = "Catppuccin-Purple-Dark";
      package = pkgs.catppuccin-gtk;
    };

  };
}
