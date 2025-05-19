{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.gui;
in
{

  #TODO: Modularize gui components
  imports = [
    # ./QT
    # ./gtk/adw-gtk3.nix
    ./firefox
    # ./zathura
    # ./pointer/pointer.nix
  ];

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
      #(prismlauncher.override { glfw = pkgs.glfw-wayland-minecraft; })

      # Utilities
      #nemo
      # (pkgs.flameshot.overrideAttrs (finalAttrs: previousAttrs: {
      #   cmakeFlags = previousAttrs.cmakeFlags
      #     ++ [ (pkgs.lib.cmakeBool "USE_WAYLAND_GRIM" true) ];
      # }))
      grimblast
      #lib.cmakeBool
      carla
      signal-desktop
      csa
      calf
      rnnoise-plugin # Denoiser plugin
      pwvucontrol
      #pwvucontrol
      gimp
      playerctl
      # bluetooth
      bluez
      bluez-tools
      blueberry

      mumble
      gajim

      # feishin

      # Productivity
      libreoffice
      #calibre

      # Media

      mpv
      imv
    ];

  };
}
