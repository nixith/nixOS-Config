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
    #nixith.mpv.codecs = ; #TODO: enable swapping codecs for non-av1 systems
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
      scripts =
        with pkgs.mpvScripts;
        [
          mpris
          visualizer
          thumbfast
          sponsorblock
          quality-menu
          uosc
        ]
        ++ (with pkgs.mpvScripts.builtins; [
          autoload
        ]);
      config = {
        hwdec = "auto";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
        demuxer-max-bytes = "1024MiB";
        demuxer-readahead-secs = 20;
        ytdl-format = "(bestvideo[height<=1440][vcodec^=av01]/bestvideo[height<=1440])+bestaudio/best"; # TODO: make vcodec extensible
        slang = "en";
        sub-auto = "fuzzy";
        ytdl-raw-options = "sub-lang=en,write-auto-sub=,write-subs=";
      };
    };
  };

}
