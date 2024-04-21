# Various Useful CLI Tools
{ config, lib, pkgs, user, inputs, ... }: {
  programs = {
    bat.enable = true; # cat clone
    fzf = {
      enable = true;
      enableFishIntegration = false; # handled with plugin
      changeDirWidgetCommand = ''
        fd . --type d --follow --exclude '*.direnv/*'
      '';
      changeDirWidgetOptions =
        [ "--preview 'eza {} -F --icons --color=always -T -L 4'" ];
      fileWidgetCommand = ''
        fd . --type f --follow --exclude '*.direnv/*'
      '';
      fileWidgetOptions =
        [ "--preview 'bat {} --paging never --color always'" ];

      defaultCommand = ''
        fd . --type d --follow --exclude '*.direnv/*'
      '';

      defaultOptions = [ ];
    };

    eza = {
      enable = true;
      extraOptions = [ "-F" "--header" ];
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
