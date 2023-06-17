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
    package = pkgs.neovim-nightly;
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

    ### Python ###
    # Linter
    ruff

    # LSP
    python311Packages.jedi-language-server
    python311Packages.ruff-lsp
    nodePackages_latest.pyright
    nodePackages_latest.vscode-json-languageserver
    sumneko-lua-language-server
    stylua
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
    shfmt
    stylua

    #nix
    alejandra.defaultPackage.${system}
    statix
    deadnix
  ];
}
