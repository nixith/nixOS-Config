{ config, lib, ... }:
{
  services = {
    tailscale = {
      useRoutingFeatures = "both";
      enable = true;
    };
  };

  # TODO: make this work right. See waybar systemd activation

  # make systray autostart
  # systemd = {
  #
  #   user.services."tailscale-systray" = {
  #     enable = true;
  #     requires = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     description = "Run the tailscale systray";
  #     documentation = [ "https://tailscale.com/kb/1597/linux-systray" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${lib.getExe config.services.tailscale.package} systray";
  #       Restart = "on-failure";
  #     };
  #
  #   };
  # };
  systemd.services.tailscaled.serviceConfig.Environment = lib.mkIf config.networking.nftables.enable [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
