{ pkgs, ... }: {
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
    luajitPackages.lua-lsp
    jdt-language-server
  ];

}
