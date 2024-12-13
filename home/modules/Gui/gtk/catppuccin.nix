{ config, lib, pkgs, user, inputs, ... }: {
  # home.pointerCursor = let pkg = pkgs.catppuccin-cursors.mochaDark;
  # in {
  #   name = pkg.pname;
  #   package = pkg;
  #   size = 16;
  # };

  gtk = {
    enable = true;

    # cursorTheme = let pkg = pkgs.catppuccin-cursors.mochaDark;
    # in {
    #   name = pkg.pname;
    #   package = pkg;
    # };

    iconTheme = let
      pkg = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    in {
      name = pkg.pname;
      package = pkg;
    };

    theme = let
      pkg = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    in {
      name = pkg.pname;
      package = pkg;
    };
  };
}
