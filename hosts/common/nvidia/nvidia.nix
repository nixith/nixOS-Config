{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libva
    ];
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    package = pkgs.config.boot.kernelPackages.nvidia_x11_beta_open;
  };

  environment.sessionVariables = {
    #LIBVA_DRIVER_NAME = "vdpau";
    #VDPAU_DRIVER = "nvidia";
  };
}
