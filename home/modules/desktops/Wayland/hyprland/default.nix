{ inputs, self, user, hyprland, home-manager, config, pkgs, computer, ... }:
let
  user = user;

  monitors = if computer == "Galaxia" then
    (import ./snippets/DesktopMonitors.nix { })
  else ''
    monitor=,preferred,auto,auto
  '';

in {
  imports = [ ../General/Waybar ../General/Rofi ../General/Dunst ];

  # Fix waybar
  programs.waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
    postPatch = ''
      # use hyprctl to switch workspaces
      sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
    '';
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (import ./config.nix {
      inherit pkgs;
      inherit monitors;
    });
    recommendedEnvironment = true;
  };

  home.packages = with pkgs; [
    swaybg
    polkit_gnome
    wl-clipboard
    swaylock-fancy
    swayidle
    brightnessctl
  ];

  services.wlsunset = {
    enable = true;
    latitude = "35.65";
    longitude = "-78.83";
  };
  xdg.configFile."hypr/Assets/tropic_island_night.jpg".source =
    ./Assets/tropic_island_night.jpg;

  # Wallpaper

}

