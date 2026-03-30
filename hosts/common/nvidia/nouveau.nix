{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nouveau" ];

  environment.systemPackages = with pkgs; [ mesa ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.drivers
      nvidia-vaapi-driver
      libva
      libva-vdpau-driver
    ];
  };
}
