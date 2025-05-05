# Vrious Useful CLI Tools
{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.nixith.cli;

in
{

  imports = [
    ./btop
    ./zellij
    ./tmux
  ];
  options = {
    nixith.cli.enable = lib.mkEnableOption "Enable cli tools";
  };
  config = lib.mkIf cfg.enable {

    programs = {
      bat.enable = true; # cat clone
      fzf = {
        enable = true;
        enableFishIntegration = false; # handled with plugin
        changeDirWidgetCommand = ''
          fd . --type d --follow --exclude '*.direnv/*'
        '';
        changeDirWidgetOptions = [ "--preview 'eza {} -F --icons --color=always -T -L 4'" ];
        fileWidgetCommand = ''
          fd . --type f --follow --exclude '*.direnv/*'
        '';
        fileWidgetOptions = [ "--preview 'bat {} --paging never --color always'" ];

        defaultCommand = ''
          fd . --type d --follow --exclude '*.direnv/*'
        '';

        defaultOptions = [ ];
      };

      eza = {
        enable = true;
        extraOptions = [
          "-F"
          "--header"
        ];
        icons = true;
        git = true;
      };

      lazygit = {
        enable = true;
      };
    };

    nixith.btop.enable = true;
    nixith.zellij.enable = true;
    home.packages = with pkgs; [
      coreutils-full
      gh
      git
      #  Archive Tools
      unzip
      gzip
      _7zz
      dash
      fd
      ripgrep
    ];
  };

}
