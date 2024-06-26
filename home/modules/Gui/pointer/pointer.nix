{ pkgs, ... }: {
  home.pointerCursor = let cursor = pkgs.catppuccin-cursors.mochaDark;
  in {
    gtk.enable = true;
    package = cursor;
    name = "catppuccin-mocha-dark-cursors";
  };
}
