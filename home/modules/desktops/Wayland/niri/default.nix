{pkgs, ...}: {
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

  services.wlsunset = {
    enable = true;
    latitude = "35.6";
    longitude = "-78.8";
  };

  programs.niri = {
    enable = true;
    config = builtins.readFile ./config.kdl;
  };
}
