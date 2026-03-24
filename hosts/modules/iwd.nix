{ pkgs, ... }:
{
  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          ControlPortOverNL80211 = false;
          AddressRandomization = "network";
          #DisableANQP = false;
        };
      };
    };
    networkmanager.wifi.backend = "iwd";
  };
  boot.kernelModules = [ "pkcs8_key_parser" ];
  environment.systemPackages = with pkgs; [ impala ];
}
