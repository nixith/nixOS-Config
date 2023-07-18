{
  inputs,
  pkgs,
  anyrun,
  ...
}: {
  programs.anyrun = {
    enable = false;
    config = {
      plugins = [
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.symbols
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.shell
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.dictionary
      ];
      width = {fraction = 0.4;};
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      #position = "top";
      #verticalOffset = {absolute = 0;};
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      #hidePluginInfo = false;
      #closeOnClick = false;
      #showResultsImmediately = false;
      maxEntries = null;
    };
    extraCss = ''
      .window {
        color: transparent
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
}
