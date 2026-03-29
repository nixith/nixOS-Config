{
  pkgs,
  ff-package ? pkgs.firefox,
  ...
}:
{
  home.packages = with pkgs; [
    firefoxpwa
    fx-cast-bridge
  ];
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      fx-cast-bridge
      ff2mpv
      firefoxpwa
    ];
    package = ff-package;
  };
}
