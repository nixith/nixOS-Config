{ config, lib, pkgs, user, inputs, nixpkgs, ... }:
let
  #prismlauncher = inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {glfw = pkgs.glfw-wayland;};
in {
  nixpkgs.config.allowUnfree = true;
  # Apps without Home Manager Modules
  home.packages = with pkgs; [
    # note taking
    xournalpp

    # Gaming
    #steamcmd
    #steam-tui
    mesa
    dxvk
    #itch #(commented due to InsecurePackage)
    (prismlauncher.override { glfw = pkgs.glfw-wayland-minecraft; })

    # Utilities
    cinnamon.nemo-with-extensions
    flameshot
    carla
    csa
    calf
    rnnoise-plugin # Denoiser plugin
    distrho
    noisetorch
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

    #art
    pixelorama

    #Libs
    xorg.libxcb
  ];
  #++ [prismlauncher];
}
