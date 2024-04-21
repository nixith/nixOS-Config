{ pkgs, ... }: {
  nixpkgs.config.firefox = {
    enableTridactylNative = true;
    enableFxCastBridge = true;
    speechSynthesisSupport = true;
  };
  programs.firefox = {
    enable = true;
    #package = pkgs.firefox.override {
    #};
  };
}
