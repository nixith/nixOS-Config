{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_Transparent";

      editor.lsp = {display-messages = true;};

      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.indent-guides = {render = true;};
    };

    themes = {
      catppuccin_Transparent = builtins.fromTOML (builtins.readFile ./themes/catppuccin_mocha.toml);
    };

    languages = [
      {
        name = "nix";
        formatter = {command = "nixpkgs-fmt";};
        auto-format = true;
      }
    ];
  };
}
