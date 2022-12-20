{pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
  cattpuccin-gtk
  catppuccin-cursors
  emacsPackages.catppuccin-theme
  ];

}
