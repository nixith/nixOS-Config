{...}: {
  programs.firefox = {
    enable = true;

    nativeMessagingHosts = {
      fxCast = true;
      ff2mpv = true;
      tridactyl = true;
    };
  };
}
