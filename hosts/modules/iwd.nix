{ ... }:
{
  networking = {
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
  };
  boot.kernelModules = [ "pkcs8_key_parser" ];
}
