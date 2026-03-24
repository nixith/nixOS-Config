{ ... }:
{
  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        General.ControlPortOverNL80211 = false;
      };
    };
    networkmanager.wifi.backend = "iwd";
  };
  boot.kernelModules = [ "pkcs8_key_parser" ];
}
