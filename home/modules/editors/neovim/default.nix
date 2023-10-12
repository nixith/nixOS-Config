{
  pkgs,
  system,
  alejandra,
  nil,
  ...
}: let
  plugins = with pkgs; [
    vimPlugins.nvim-treesitter.withAllGrammars
  ];
in {
  # move config files to .config

  home.file.nvim = {
    enable = true;
    recursive = true;
    source = ./nvim;
    target = ".config/nvim";
  };

  programs.neovim = {
    enable = true;
    #package = neovim-nightly;
    withPython3 = true;
    withNodeJs = true;
    inherit plugins;
  };

  home.packages = with pkgs; [
    # extension dependencies
    luajitPackages.jsregexp
    ripgrep
    lazygit
    wget
    curl
    go
    nodePackages.npm
    gcc
    fd
    tree-sitter
    libstdcxx5

    ### Python ###
    # Linter

    # LSP
    ruff-lsp
    pylyzer
    # yaml
    nodePackages_latest.yaml-language-server
    yamlfmt
    nodePackages_latest.vscode-json-languageserver
    sumneko-lua-language-server
    nodePackages_latest.pyright
    ### Rust ###
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    #
    rust-analyzer-nightly

    ### Java ###
    jdt-language-server
    vscode-extensions.vscjava.vscode-java-test
    vscode-extensions.vscjava.vscode-java-debug

    # debugger?
    vscode-extensions.vadimcn.vscode-lldb

    # tomly thing I use for rust

    ### Formatters: ###
    stylua
    alejandra.defaultPackage.${system}
    beautysh
    bibtex-tidy
    shellcheck
    shellharden
    shfmt
    ruff
    nodePackages_latest.stylelint
    taplo
    yamlfmt

    #nix
    statix
    nixd
    deadnix

    #typst
    typst
    typst-lsp

    #linters
    stylua
    nodePackages_latest.jsonlint
    languagetool
    selene

    # spelling
    proselint
    nodePackages_latest.textlint
    typos
    vale
    ltex-ls

    ## markdown
    nodePackages_latest.cspell
    nodePackages_latest.markdownlint-cli2
    nodePackages_latest.markdownlint-cli
  ];
}
