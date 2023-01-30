{ home-manager, pkgs, ... }:

{
  #imports = [ ./nightlyBuilds.nix ];
  home.packages = with pkgs;
    [
      xournalpp
    ];

  xdg.configFile."xournalpp/palette.gpl".source = ./palette.gpl;
  xdg.configFile."xournalpp/settings.xml".source = ./settings.xml;
}
