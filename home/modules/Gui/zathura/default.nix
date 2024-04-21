{ home, ... }: {
  programs.zathura = {
    enable = true;
    extraConfig = ''
      include catppuccin-mocha
      set selection-clipboard clipboard
      set recolor
    '';
  };
  xdg.configFile."zathura/catppuccin-mocha".source = ./catppuccin-mocha;
}
