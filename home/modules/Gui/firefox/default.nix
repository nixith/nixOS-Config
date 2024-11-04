{ pkgs, ... }: {
  nixpkgs.config.firefox = {
    enableTridactylNative = true;
    enableFxCastBridge = true;
    speechSynthesisSupport = true;
  };
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ tridactyl-native fx-cast-bridge ];
    package = pkgs.firefox-bin;
  };
}
