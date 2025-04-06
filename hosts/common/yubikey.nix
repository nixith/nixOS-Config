{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.yubikey-personalization ];
  boot.initrd.services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
