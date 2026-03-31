{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.run0;
in
{

  options.nixith.run0 = {
    enable = lib.mkEnableOption "enable run0 over sudo";
    config = lib.mkOption {
      type = lib.types.str;
      description = "niri config (make into nix config eventually)";
    };
  };

  config = lib.mkIf cfg.enable {
    # we have run0 already, its part of systemd
    security.sudo = {
      # dangerous games here lmao
      enable = false;
    };

    system.tools.nixos-rebuild.enableRun0Elevation = true;
    security.run0 = {
      enable = true;
      sudo-shim.enable = true;
      persistentAuth.enable = true;
    };
  };

}
