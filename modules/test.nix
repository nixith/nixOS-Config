{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.flameshot ];
  services.dbus.packages = [ pkgs.flameshot ];
}

{ packages = [ " a" ]; }
