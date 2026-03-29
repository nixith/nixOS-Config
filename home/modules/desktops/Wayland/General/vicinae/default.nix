{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.vicinae;

  vicinae-extensions-repo = (import (../../../../../../npins)).vicinae-extensions;
  vicinae-extensions = (
    lib.pipe (builtins.readDir "${vicinae-extensions-repo}/extensions") [
      (lib.filterAttrs (_name: type: type == "directory"))
      (lib.mapAttrs (
        name: _type:
        config.lib.vicinae.mkExtension {
          pname = "vicinae-extension-${name}";
          version = "0";
          src = ./extensions/${name};
          postPatch = ''
            substituteInPlace tsconfig.json --replace "../../" "${./.}/"
          '';
        }
      ))
    ]
  );

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
    home.packages = with pkgs; [
      power-profiles-daemon
    ];

    programs.vicinae = {
      enable = true;
      systemd.enable = true;

      extensions = with vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
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

        providers = {
          "@Gelei/vicinae-extension-bluetooth-0" = {
            preferences.connectionToggleable = true;
          };
          "@dagimg-dot/vicinae-extension-wifi-commander-0" = {
            preferences.network-cli-tool = "iwctl";
          };
          "browser-extension".enabled = false;
          core.entrypoints = {
            report-bug.enabled = false;
            sponsor.enabled = false;
          };
          developer.enabled = false;
          raycast-compat.enabled = false;
        };
      };
    };

  };

}
