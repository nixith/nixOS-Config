{ pkgs, ... }: {
  home.packages = with pkgs; [
    slurp
    xdg-dbus-proxy
    swww
    polkit_gnome
    wl-clipboard
    clipboard-jh
    brightnessctl
    grim
    #anyrun
    sway-contrib.grimshot
  ];

  programs.niri = { config = builtins.readFile ./config.kdl; };
}
