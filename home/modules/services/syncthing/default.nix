{ config, lib, ... }:
let
  cfg = config.nixith.syncthing;
in
{
  options = {
    nixith.syncthing.enable = lib.mkEnableOption "enable syncthing";
  };
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
