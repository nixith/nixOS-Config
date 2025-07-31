{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.nixith.swayidle;

in
{

  options.nixith.swayidle = {
    enable = lib.mkEnableOption "enable swayidle";
  };
  config = lib.mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      events = [
        {
          # lock whenever we sleep
          event = "before-sleep";
          command = "loginctl lock-session";
        }
        {
          event = "lock";
          command = lib.getExe pkgs.gtklock;
        }
      ];
      timeouts = [
        {
          #TODO: figure out screen dimming earlier
          timeout = 560;
          command = "${lib.getExe pkgs.systemd "systemctl"} suspend";
        }
      ];
    };
  };

}
