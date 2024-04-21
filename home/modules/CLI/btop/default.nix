{ ... }: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "./catppuccinMocha.theme";
      theme_background = false;
    };
  };
}
