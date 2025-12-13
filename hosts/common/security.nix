{ pkgs, lib, ... }:
{
  ### apparmor

  security.apparmor = {
    enable = true;
  };

  services.dbus.apparmor = "enabled";

  # Grant passwod to certain apps
  security.pam.services = {
    swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  ### Firejail
  #TODO: put firejail with firefox pakages in general
  #   programs.firejail = {
  #     enable = true;
  #     wrappedBinaries = {
  #       firefox = {
  #         executable = "${lib.getBin pkgs.firefox}/bin/firefox";
  #         profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
  #       };
  #     };
  #   };
}
