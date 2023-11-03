{config, ...}: {
  hardware.nvidia.modesetting.enable = true;
  boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia-uvm" "nvidia_drm"];
  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau"];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidia_x11_beta;
    # package = config.boot.kernelPackages.nvidia_x11_vulkan_beta;
    # modesetting should resolve tearing, but it doesn't seem to do
    # anything.
    modesetting.enable = true;
  };

  #nvidia = builtins.getEnv "NVIDIA" != "";
}
