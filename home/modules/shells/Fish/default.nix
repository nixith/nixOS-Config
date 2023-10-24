{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vivid # generate LS_COLORS for catppuccin
  ];
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ls = "eza";
      la = "eza -a";
      ll = "eza -al";
    };
    shellInit = builtins.readFile ./config.fish;
    plugins = [
      #{
      #  name = "fzf.fish";
      #  src = inputs.fish-fzf;
      #}
      {
        name = "z";
        src = inputs.fish-z;
      }
      {
        name = "fzf";
        src = inputs.fish-fzf;
      }
    ];
  };
}
