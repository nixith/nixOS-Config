{
  pkgs,
  system,
  alejandra,
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
    ripgrep
    lazygit
    wget
    curl
    go
    rustup
    nodePackages.npm
    gcc
    fd
    tree-sitter
    libstdcxx5

    #Python
    # Linter
    ruff

    # LSP
    python310Packages.jedi-language-server
    nodePackages_latest.pyright
    nodePackages_latest.vscode-json-languageserver
    sumneko-lua-language-server
    stylua
    jdt-language-server

    # Formatter
    alejandra.defaultPackage.${system}
  ];
}
