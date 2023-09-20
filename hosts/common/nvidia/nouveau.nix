{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nouveau"];

  environment.systemPackages = with pkgs; [
    mesa
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.drivers
      nvidia-vaapi-driver
      vaapiVdpau
      libva
    ];
  };
}
