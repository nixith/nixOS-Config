{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.nixith.swaync;

in
{

  options.nixith.swaync = {
    enable = lib.mkEnableOption "enable swaync";
  };
  config = lib.mkIf cfg.enable {
    services.swaync = {
      enable = true;
      settings = {
        widgets = [
          "title"
          "dnd"
          "mpris"
          "inhibitors"
          "notifications"
        ];
      };
    };

    xdg.portal = {
      config = {
        common = {
          screencast = [
            ''exec_before=${lib.getExe config.services.swaync.package} --inhibitor-add "xdg-desktop-portal-screenshare"''
            ''exec_after=${lib.getExe config.services.swaync.package} --inhibitor-remove "xdg-desktop-portal-screenshare"''
          ];
        };
      };
    };
  };

}
