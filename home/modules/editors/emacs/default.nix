{ pkgs, nix-doom-emacs, ... }:
{
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true
      doomPrivateDir = ./.doom.d
    };
    home.packages = with pkgs; [
      # Latex
      texlab #lsp
      tectonic #Latex compiler
      pkgs.texlive.combined.scheme-medium #tex itself

      # Nix
      nixfmt

      # org
      gnuplot

      #python
      nodePackages_latest.pyright #lsp

      # Shell
      nodePackages_latest.bash-language-server

      #rust
      rust-analyzer-unwrapped

      #json
      nodePackages_latest.vscode-json-languageserver


    ];
  }
