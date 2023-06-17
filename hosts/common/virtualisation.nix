{
  pkgs,
  user,
  ...
}: {
  virtualisation = {
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

  environment.systemPackages = [pkgs.virt-manager pkgs.distrobox pkgs.shadow];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.${user}.extraGroups = ["podman"];
}
