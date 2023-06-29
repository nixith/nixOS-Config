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
    python311Packages.ruff-lsp
    pylyzer
    nodePackages_latest.vscode-json-languageserver
    sumneko-lua-language-server
    jdt-language-server

    ### Rust ###
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly

    ### Formatters: ###
    stylua

    #nix
    alejandra.defaultPackage.${system}
    statix
    nixd
    deadnix
  ];
}
