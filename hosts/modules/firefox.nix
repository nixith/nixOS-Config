{_}: {
  programs.firefox = {
    nativeMessagingHosts = {
      fxcast = true;
      ff2mpv = true;
      tridactyl = true;
    };
  };
}
