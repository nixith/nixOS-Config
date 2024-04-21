{ home-manager, ... }: {
  home.file."./wallpapers" = {
    source = ./wallpapers;
    enable = true;
    recursive = true;
    target = "./Pictures/wallpapers";
  };
}
