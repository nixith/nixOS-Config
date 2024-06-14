{ pkgs, user, config, ... }:
let
  isNvidia = pkgs.lib.any (driver: driver == "nvidia")
    config.services.xserver.videoDrivers;
in {
  virtualisation = {
    # enable nvidia stuff for containers. Any CDI container spec supports this.
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
    #qemu = {
    #    package = pkgs.qemu_kvm;
    #    guestAgent.enable = true;
    #  };
  };

  environment.systemPackages = [ pkgs.virt-manager pkgs.distrobox pkgs.shadow ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    autoPrune = { enable = true; };
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.${user}.extraGroups = [ "podman" ];
}
