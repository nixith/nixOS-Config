{ lib, config, ... }:
let
  cfg = config.nixith.btop;
in
{
  options = {
    nixith.btop.enable = lib.mkEnableOption "Enable cli items";
  };
  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        #color_theme = "./catppuccinMocha.theme";
        #theme_background = false;
      };
    };
  };
}
