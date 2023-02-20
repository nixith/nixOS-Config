{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    tray = true;
  };
}
