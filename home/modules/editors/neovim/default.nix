{ pkgs, ... }:
{
  programs.neovim = {
    enable = false;
  };

  home.packages = with pkgs; [
    ripgrep
    lazygit
    bottom
  ];
}
