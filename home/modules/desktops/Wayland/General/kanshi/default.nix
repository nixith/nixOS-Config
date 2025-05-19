{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.kanshi;
in
{

  options.nixith.kanshi = {
    enable = lib.mkEnableOption "enable kanshi";
    config = lib.mkOption {
      type = lib.types.str;
      description = "kanshi config (make into nix config eventually)";
    };
  };

  config = lib.mkIf cfg.enable {
    # osConfig = {
    #   xdg = {
    #     autostart.enable = true;
    #     menus.enable = true;
    #     mime.enable = true;
    #     icons.enable = true;
    #   };
    #   security.pam.services.swaylock = { };
    # };

    services.kanshi = {
      enable = true;
      profiles = {
        laptop = {
          outputs = [ { criteria = "eDP-1"; } ];
        };
        wDock = {

          outputs = [
            { criteria = "eDP-1"; }
            { criteria = "Dell Inc. DELL U2723QE 1V17WN3"; }
          ];
        };
        desktop = {
          outputs = [
            {
              #criteria = "Dell Inc. DELL P2312H XTK9N275GLYL";
              criteria = "HDMI-A-1";
              transform = "90";
              position = "2970,0";
            }
            {
              criteria = "DP-1";
              position = "1050,300";
            }
            {
              criteria = "DP-2";
              position = "0,0";
              transform = "90";
            }
          ];
        };
      };
    };

  };
}
