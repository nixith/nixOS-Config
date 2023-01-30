{ ... }:
{

  programs.lsd.enable = true;
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "lsd";
      la = "lsd -a";
    };
    shellInit = builtins.readFile ./config.fish;

  };
}
