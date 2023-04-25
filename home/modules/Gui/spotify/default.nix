{pkgs, ...}: {
  home.packages = with pkgs; [spotify-tui];

  programs.spotifyd = {};
}
