{
  pkgs,
  system,
  alejandra,
  nil,
  ...
}: {
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
    plugins = with pkgs; [
      vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  home.packages = with pkgs; [
    # needed for luarocks
    luajit
    tree-sitter-grammars.tree-sitter-typst
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
    ruff
    python312Packages.debugpy

    # yaml
    nodePackages_latest.yaml-language-server
    yamlfmt
    nodePackages_latest.vscode-json-languageserver
    lua-language-server
    nodePackages_latest.pyright
    ### Rust ###
    # (fenix.complete.withComponents [
    #   "cargo"
    #   "clippy"
    #   "rust-src"
    #   "rustc"
    #   "rustfmt"
    # ])
    #
    cargo
    clippy
    rust-analyzer

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

    #typst # breaking builds as of now, rely on direnv
    # typst
    # typst-fmt
    # typst-lsp

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
