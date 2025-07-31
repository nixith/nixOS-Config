{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.mpv;
in
{
  options = {
    nixith.mpv.enable = lib.mkEnableOption "Enable mpv config";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        visualizer
        thumbfast
        sponsorblock
        quality-menu
      ];
    };
  };

}
