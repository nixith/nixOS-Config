{
  config,
  pkgs,
  ...
}:
let
  user = config.nixith.user;
in
{
  virtualisation = {
    qemu = {
      firmware.enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune = {
        enable = true;
      };
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  users.users.${user}.extraGroups = [ "podman" ];
}
