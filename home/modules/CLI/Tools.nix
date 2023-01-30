# Various Useful CLI Tools
{ config, lib, pkgs, user, inputs, ... }:

{
  programs = {
    bat.enable = true; # cat clone
    exa.enable = true; # ls clone
    fzf = {
      enable = true;
      colors = {
        "bg+" = "#313244";
        bg = "#1e1e2e";
        spinner = "#f5e0dc";
        hl = "#f38ba8";
        fg = "#cdd6f4";
        header = "#f38ba8";
        info = "#cba6f7";
        pointer = "#f5e0dc";
        arker = "#f5e0dc";
        "fg+" = "#cdd6f4";
        prompt = "#cba6f7";
        "hl+" = "#f38ba8";
      };

    };
    zathura.enable = true;

  };
  home.packages = with pkgs; [
    coreutils-full
    #  Archive Tools
    unzip
    gzip
    _7zz
  ];
}
