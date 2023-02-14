{ pkgs, nix-doom-emacs, inputs, self, ... }: rec {
  #nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

  home.file."./doom.d/themes" = {
    recursive = true;
    source = ./doom.d/themes;
    target = "./.doom.d/themes";
  };

  # Get a newer version of emacs
  services.emacs = { enable = true; };
  nixpkgs.overlays = [ (import ./overlays/python) ];
  programs.doom-emacs = rec {
    enable = true;
    doomPrivateDir = ./doom.d;

    doomPackageDir = let
      filteredPath = builtins.path {
        path = doomPrivateDir;
        name = "doom-private-dir-filtered";
        filter = path: type:
          builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
      };
    in pkgs.linkFarm "doom-packages-dir" [
      {
        name = "init.el";
        path = "${filteredPath}/init.el";
      }
      {
        name = "packages.el";
        path = "${filteredPath}/packages.el";
      }
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
    ];
  };

  home.packages = with pkgs; [
    # General
    ripgrep

    #Tree-sitter
    tree-sitter

    # Latex
    texlab # lsp
    tectonic # Latex compiler
    pkgs.texlive.combined.scheme-medium # tex itself

    # Nix
    nixfmt

    # org
    gnuplot

    #python
    nodePackages_latest.pyright # lsp
    haskellPackages.tree-sitter-python
    tree-sitter-grammars.tree-sitter-python

    # Shell
    nodePackages_latest.bash-language-server

    #rust
    rust-analyzer-unwrapped

    #json
    nodePackages_latest.vscode-json-languageserver

    #nix
    nil

    #vterm
    cmake
    libvterm
    libtool
  ];
}
