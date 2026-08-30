{
  config,
  ...
}:
let
  user = config.nixith.user;
in
{
  # virtualisation = {
  #   # enable nvidia stuff for containers. Any CDI container spec supports this.
  #   libvirtd = {
  #     enable = true;
  #   };
  #   spiceUSBRedirection.enable = true;
  #   #qemu = {
  #   #    package = pkgs.qemu_kvm;
  #   #    guestAgent.enable = true;
  #   #  };
  # };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    autoPrune = {
      enable = true;
    };
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.${user}.extraGroups = [ "podman" ];
}
