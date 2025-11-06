{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefoxpwa
    fx-cast-bridge
  ];
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      tridactyl-native
      fx-cast-bridge
      ff2mpv
      firefoxpwa
    ];
    package = pkgs.firefox;
    #TODO: make declarative profile
    # profiles."test" = { };
  };
}
