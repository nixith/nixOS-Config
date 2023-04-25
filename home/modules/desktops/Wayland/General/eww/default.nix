{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    socat
    lm_sensors
  ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./ewwConf;
  };
}
