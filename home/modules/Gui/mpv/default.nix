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

    programs.aria2.enable = true;
    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        embed-subs = true;
        sub-langs = "all";
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
    services.jellyfin-mpv-shim = {
      enable = true;
      mpvConfig = config.programs.mpv.config; # TODO: write dedicated config
    };
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        mpris
        visualizer
        thumbfast
        sponsorblock
        quality-menu
        uosc
      ];
      config = {
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
        demuxer-max-bytes = "512MiB";
        demuxer-readahead-secs = 20;
        ytdl-format = "bestvideo+bestaudio/best";
        slang = "en";
        sub-auto = "fuzzy";
        ytdl-raw-options = "sub-lang=en,write-auto-sub=,write-subs=";
      };
    };
  };

}
