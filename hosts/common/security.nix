{
  pkgs,
  lib,
  ...
}: {
  ### apparmor

  security.apparmor = {
    enable = true;
  };

  services.dbus.apparmor = "enabled";

  ### Firejail
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    };
  };
}
