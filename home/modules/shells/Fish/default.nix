{...}: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "eza";
      la = "eza -a";
      ll = "eza -al";
    };
    shellInit = builtins.readFile ./config.fish;
  };
}
