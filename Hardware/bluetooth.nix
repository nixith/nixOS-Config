{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetoth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}
