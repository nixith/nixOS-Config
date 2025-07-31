{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.nixith.swayosd;
in
{

  options.nixith.swayosd = {
    enable = lib.mkEnableOption "enable swayosd";
  };
  config = lib.mkIf cfg.enable {
    services.swayosd = {
      enable = true;
    };
  };

}
