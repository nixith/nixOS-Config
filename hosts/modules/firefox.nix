{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    nativeMessagingHosts.packages = with pkgs; [
      fx-cast-bridge
      ff2mpv-rust
      tridactyl-native
    ];
  };
}
