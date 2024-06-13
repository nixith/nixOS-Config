{ config, lib, pkgs, user, inputs, ... }: {
  gtk = {
    enable = true;

    cursorTheme = let pkg = pkgs.catppuccin-cursors.mochaDark;
    in {
      name = pkg.pname;
      package = pkg;
    };

    iconTheme = let
      flavor = "mocha";
      accent = "lavender";
      pkg = pkgs.catppuccin-papirus-folders.override {
        flavor = flavor;
        accent = accent;
      };
    in {
      name = "Papirus";
      package = pkg;
    };

    theme = let pkg = pkgs.adw-gtk3;
    in {
      name = pkg.pname;
      package = pkg;
    };
  };
}
