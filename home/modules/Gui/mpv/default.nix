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
      config = {
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
      };
    };
  };

}
