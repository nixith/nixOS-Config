{ config, lib, ... }:
let
  cfg = config.nixith.ghostty;
in
{
  options = {
    nixith.ghostty.enable = lib.mkEnableOption "enable the foot terminal";
  };
  config = lib.mkIf cfg.enable {

    xdg.terminal-exec.settings = {
      default = [ "com.mitchellh.ghostty.desktop" ];
    };
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
    };
  };
}
