{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ tridactyl-native fx-cast-bridge ];
    package = pkgs.firefox;
    #TODO: make declarative profile
    profiles."test" = {

    };
  };
}
