{pkgs, ...}: {
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

  environment.systemPackages = [pkgs.virt-manager];
}
