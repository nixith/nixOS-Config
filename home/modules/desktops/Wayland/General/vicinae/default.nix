vicinae-extensions:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.vicinae;
in
{

  options.nixith.vicinae = {
    enable = lib.mkEnableOption "enable vicinae";
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
    #
    # };

    programs.vicinae = {
      enable = true;
      systemd.enable = true;
      extensions = [
        (config.lib.vicinae.mkExtension {
          name = "bluetooth";
          src = vicinae-extensions + "/extensions/bluetooth";
        })
        # (config.lib.vicinae.mkExtension {
        #   name = "HTML Symbol Finder";
        #   src = vicinae-extensions + "/extensions/html-symbol-finder";
        # })
        # (config.lib.vicinae.mkExtension {
        #   name = "Player Pilot";
        #   src = vicinae-extensions + "/extensions/player-pilot";
        # })
        # (config.lib.vicinae.mkExtension {
        #   name = "Wifi";
        #   src = vicinae-extensions + "/extensions/wifi-commander";
        # })
      ];

      settings = {
        faviconService = "twenty";
        font = {
          size = 10;
        };
        popToRootOnClose = false;
        rootSearch = {
          searchFiles = false;
        };
        theme = {
          name = "vicinae-dark";
        };
        window = {
          csd = true;
          opacity = 0.95;
          rounding = 10;
        };
      };
    };

  };

}
