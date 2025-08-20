{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.nixith.fnott;

in
{

  options.nixith.fnott = {
    enable = lib.mkEnableOption "enable fnott";
  };
  config = lib.mkIf cfg.enable {
    services.fnott = {
      enable = true;
    };
  };
}
