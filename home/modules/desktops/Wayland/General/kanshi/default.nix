{ config, lib, pkgs, ... }:
let cfg = config.nixith.kanshi;
in {

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
        laptop = { outputs = [{ criteria = "eDP-1"; }]; };
        desktop = {
          outputs = [
            {
              criteria = "Dell Inc. DELL P2312H XTK9N275GLYL";
              transform = "90";
              position = "-1080,0";
            }
            {
              criteria = "Samsung Electric Company S24E450 HCHN203427";
              position = "0,0";
            }
            {
              criteria = "Ancor Communications Inc ASUS VS247 D9LMTF289673";
              position = "1920,0";
            }
          ];
        };
      };
    };

  };
}
