{ lib, ... }:
{
  networking.networkmanager.enable = lib.mkForce false;
  #networking.useNetworkd = false; # so we just script with networkd
  systemd.network.enable = true;
  systemd.network = {

    links."10-wlan" = {
      # Check systemd.link(5) for other matchers
      matchConfig.Path = "pci-0000:a6:00.0"; # TODO: change this based on facter config
      linkConfig.Name = "wlan";
    };
    networks = {
      "20-wireless" = {
        matchConfig.Name = "wlan";
        linkConfig.RequiredForOnline = "routable";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
          DNSOverTLS = "opportunistic";
          DNSSEC = "allow-downgrade";
        };
      };
    };
  };
}
