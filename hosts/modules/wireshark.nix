{ user, pkgs, ... }:
{
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };

  users.users.${user}.extraGroups = [ "wireshark" ];
}
