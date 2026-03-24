{ lib, ... }:
{
  networking.networkmanager.enable = lib.mkForce false;
  systemd.network.enable = true;
  systemd.network = {

    links."10-wan" = {
      # Check systemd.link(5) for other matchers
      matchConfig.Path = "pci-0000:a6:00.0";
      linkConfig.Name = "wan";
    };
    networks = {
      "20-wireless" = {
        matchConfig.Name = "wan";
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
