{
  config,
  lib,
  pkgs,
  user,
  inputs,
  nixpkgs,
  ...
}: let
  #prismlauncher = inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {glfw = pkgs.glfw-wayland;};
in {
  nixpkgs.config.allowUnfree = true;
  # Apps without Home Manager Modules
  home.packages = with pkgs; [
    # note taking
    xournalpp
    logseq

    # Gaming
    #steamcmd
    #steam-tui
    mesa
    dxvk
    #itch #(commented due to InsecurePackage)
    #prismlauncher.packages.${pkgs.system}.prismlauncher

    # Utilities
    cinnamon.nemo-with-extensions
    flameshot
    carla
    csa
    calf
    rnnoise-plugin # Denoiser plugin
    distrho
    cadence
    noisetorch
    pavucontrol
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
