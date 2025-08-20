{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.nixith.music;
in
{

  options.nixith.music = {
    enable = lib.mkEnableOption "enable music services";
    extraConfigFiles = lib.mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.path;
      description = ''
        Extra configuration files read by Mopidy when the service starts.
        Later files in the list override earlier configuration files and
        structured settings.
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    services.mopidy = {
      enable = true;
      extensionPackages = with pkgs; [
        mopidy-spotify
        mopidy-mpd
        mopidy-somafm
        mopidy-jellyfin
        mopidy-ytmusic
      ];
      extraConfigFiles = cfg.extraConfigFiles;
    };
    home.packages = with pkgs; [
      euphonica
    ];

  };

}
