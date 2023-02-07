{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
  };
  xdg.configFile."nvim/init.lua".source = ./config/init.lua;
  home.packages = with pkgs;
    [
      ripgrep
      lazygit
      wget
      curl
      go
      cargo
      python311
      python311.pkgs.pip
      nodePackages.npm
      zig
      nil
    ];


}
