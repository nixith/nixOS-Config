anyrun:
{ pkgs, config, lib, ... }:
let cfg = config.nixith.anyrun;
in {

  imports = [ anyrun.homeManagerModules.default ];

  options.nixith.anyrun = { enable = lib.mkEnableOption "enable anyrun"; };
  config = lib.mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = [
          # An array of all the plugins you want, which either can be paths to the .so files, or their packages
          anyrun.packages.${pkgs.system}.applications
          anyrun.packages.${pkgs.system}.symbols
          anyrun.packages.${pkgs.system}.rink
          anyrun.packages.${pkgs.system}.shell
          anyrun.packages.${pkgs.system}.translate
          anyrun.packages.${pkgs.system}.dictionary
        ];
        width = { fraction = 0.4; };
        x = { fraction = 0.5; };
        y = { fraction = 5.0e-2; };
        #position = "top";
        #verticalOffset = {absolute = 0;};
        hideIcons = false;
        ignoreExclusiveZones = true;
        layer = "overlay";
        hidePluginInfo = true;
        #closeOnClick = false;
        #showResultsImmediately = false;
        maxEntries = null;
      };
      extraCss = ''
        .window {
          color: transparent,
        }
      '';

      #extraConfigFiles."some-plugin.ron".text = ''
      #  Config(
      #    // for any other plugin
      #    // this file will be put in ~/.config/anyrun/some-plugin.ron
      #    // refer to docs of xdg.configFile for available options
      #  )
      #'';
    };
  };
}
