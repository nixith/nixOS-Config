{home, ...}: {
  programs.rio = {
    enable = true;
    config = {
      cursor = "|";
      blinking-cursor = true;
      performance = "High";
      background = {
        opacity = 0.6;
      };
      fonts = {
        size = 10;
        regular = {
          familt = "Lilex Nerd Font Regular";
        };
      };
    };
  };
}
