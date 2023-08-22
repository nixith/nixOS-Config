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

    ## nullLS requirements ##
    stylua
    selene
    shfmt
    shellcheck
    beautysh

    ### Python ###
    # Linter
    ruff

    # LSP
    ruff-lsp
    pylyzer
    nodePackages_latest.vscode-json-languageserver
    sumneko-lua-language-server
    nodePackages_latest.pyright
    jdt-language-server
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

    # debugger?
    vscode-extensions.vadimcn.vscode-lldb

    # tomly thing I use for rust
    taplo

    ### Formatters: ###
    stylua

    #nix
    alejandra.defaultPackage.${system}
    statix
    nixd
    deadnix

    #typst
    typst
    typst-lsp
  ];
}
