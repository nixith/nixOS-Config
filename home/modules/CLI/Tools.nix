# Various Useful CLI Tools
{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}: let
  skimColors = "--color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086";
in {
  programs = {
    bat.enable = true; # cat clone
    skim = {
      enable = true;
      changeDirWidgetCommand = ''
        fd . --type d --follow --exclude '*.direnv/*'
      '';
      changeDirWidgetOptions = [
        "--preview 'eza {} -F --icons --color=always -T -L 4'"
        skimColors
      ];
      fileWidgetCommand = ''
        fd . --type f --follow --exclude '*.direnv/*'
      '';
      fileWidgetOptions = [
        "--preview 'bat {} --paging never --color always'"
        skimColors
      ];

      defaultCommand = ''
        fd . --type d --follow --exclude '*.direnv/*'
      '';

      defaultOptions = [
        skimColors
      ];
    };

    eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "-F"
        "--header"
      ];
      icons = true;
      git = true;
    };
  };

  home.packages = with pkgs; [
    coreutils-full
    #  Archive Tools
    unzip
    gzip
    _7zz
    dash
  ];
}
