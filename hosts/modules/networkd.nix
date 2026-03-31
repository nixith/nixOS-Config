{ lib, ... }:
{
  networking.networkmanager.enable = lib.mkForce false;
  #networking.useNetworkd = false; # so we just script with networkd
  systemd.network.enable = true;
  networking.useNetworkd = true;
  networking.nameservers = [
    # quad9
    ##https
    "https://dns.quad9.net/dns-query"
    ## TLS
    "tls://dns.quad9.net"
    ## ipv6
    "2620:fe::fe"
    "2620:fe::9"
    ## ipv4
    "9.9.9.9"
    "149.112.112.112"
  ];

  # networkd
  systemd.network = {

    # TODO: make the network paths configurable
    # TODO: catch case of phone acting as bridged router
    # TODO: catch case of extra usb modem
    links = {
      "20-wlan0" = {
        # Check systemd.link(5) for other matchers
        matchConfig.Path = "pci-0000:a6:00.0";
        linkConfig.Name = "wlan0";
      };
      "20-eth0" = {
        matchConfig.Path = "pci-0000:00:0d.0-usb-0:2.1.2:1.0";
        linkConfig.Name = "eth0";
      };
    };

    networks = {
      "30-wireless" = {
        matchConfig.Name = "wlan0";
        linkConfig.RequiredForOnline = "routable";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
          DNSOverTLS = "opportunistic";
          DNSSEC = "allow-downgrade";
        };
      };
      "30-wired" = {
        matchConfig.Name = "eth0";
        linkConfig.RequiredForOnline = false;
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true;
          DNSOverTLS = "opportunistic";
          DNSSEC = "allow-downgrade";
        };
      };
    };
  };

  services.resolved = {
    # works better with tailscale
    enable = true;
    settings.Resolve = {
      ReadEtcHosts = "yes";
      DNSSEC = "allow-downgrade";
      DNSOverTLS = "opportunistic";
      FallbackDNS = [
        # mullvad
        #"dns.mullvad.net" #NOTE: if the entry below breaks, use this
        "adblock.dns.mullvad.net"
      ];
    };
  };
  # resolved (should be used with networkd regardless)
}
