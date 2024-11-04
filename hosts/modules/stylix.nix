{ inputs, ... }: {
  imports = [ inputs.stylix.nixosModule ];
  stylix = {
    enable = true;
    wallpaper =
      ../../home/modules/desktops/Wayland/hyprland/Assets/tropic_island_night.jpg;
    polarity = "dark";
  };

}
