{ hyprland, ... }: {
  programs.waybar = {
    enable = true;
    settings = import ./config.nix;
    style = builtins.readFile ./style.css;
  };

  xdg.configFile."waybar/mocha.css".source = ./mocha.css;
}
