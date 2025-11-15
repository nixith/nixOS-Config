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
      extensions = with vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        niri
        html-symbol-finder
        player-pilot
        power-profile
        wifi-commander
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
