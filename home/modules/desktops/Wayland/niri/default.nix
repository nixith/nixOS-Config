niri:
{ config, lib, pkgs, ... }:
let cfg = config.nixith.niri;
in {

  imports = [ ../General/eww ../General/mako niri.homeModules.niri ];

  options.nixith.niri = {
    enable = lib.mkEnableOption "enable niri";
    config = lib.mkOption {
      type = lib.types.str;
      description = "niri config (make into nix config eventually)";
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
    nixith.anyrun.enable = true;
    home.packages = with pkgs; [
      webcord-vencord
      #easyeffects
      wl-clipboard-rs
    ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      inherit (cfg) config;
    };
  };

}
