{ pkgs
, config
, lib
, ...
}:
let
  cfg = config.nixith.waybar;
in
{

  #imports = [ waybar.homeManagerModules.default ];

  options.nixith.waybar = {
    enable = lib.mkEnableOption "enable waybar";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      #cava.enable = true;
      waybar = {
        systemd.enable = true;
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 15;
            output = [
              "eDP-1"
              "HDMI-A-1"
            ];
            modules-left = [ "niri/workspaces" ];
            modules-center = [
              #"mpris"
            ];
            modules-right = [
              "tray"
              "wireplumber"
              "battery"
              "clock"
            ];
          };
        };
      };

    };
  };

}
