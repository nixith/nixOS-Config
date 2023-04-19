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
  ];

}
