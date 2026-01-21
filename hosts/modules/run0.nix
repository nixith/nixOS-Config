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

    security.run0 = {
      enableSudoAlias = true;
    };

    # allow password caching for polkit >= 127, whenever that is
    security.polkit.extraConfig = /* javascript */ ''
      polkit.addRule(function(action, subject) {
          if (
              action.id == "org.freedesktop.systemd1.run" &&
              subject.isInGroup("wheel")
          ) {
              return polkit.Result.AUTH_KEEP;
          }
      });

      polkit.addRule(function(action, subject) {
       if (subject.user == "alice") {
         if (action.id.indexOf("org.nixos") == 0) {
           polkit.log("Caching admin authentication for single NixOS operation");
           return polkit.Result.AUTH_ADMIN_KEEP;
         }
       }});
    '';

  };

}
