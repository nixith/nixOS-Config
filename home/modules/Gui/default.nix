{ config, lib, pkgs, ... }:
let cfg = config.nixith.gui;
in {

  options = {
    nixith.gui.enable = lib.mkEnableOption "enable various GUI items";
  };

  config = lib.mkIf cfg.enable {
    # Apps without Home Manager Modules
    #
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      # Gaming
      #itch #(commented due to InsecurePackage)
      (prismlauncher.override { glfw = pkgs.glfw-wayland-minecraft; })

      # Utilities
      cinnamon.nemo-with-extensions
      flameshot
      carla
      csa
      calf
      rnnoise-plugin # Denoiser plugin
      pavucontrol
      #pwvucontrol
      gimp
      playerctl
      # bluetooth
      bluez
      bluez-tools
      blueberry

      # Productivity
      libreoffice
      calibre

      # Media
      mpv
      imv
    ];

  };
}
