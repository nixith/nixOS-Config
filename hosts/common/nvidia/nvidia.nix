{ config, pkgs, ... }: {
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemory" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    extraPackages = with pkgs; [ nvidia-vaapi-driver vaapiVdpau libva ];
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidia_x11_beta;
  };

  environment.sessionVariables = {
    #LIBVA_DRIVER_NAME = "vdpau";
    #VDPAU_DRIVER = "nvidia";
  };
}
