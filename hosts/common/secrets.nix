{
  sops-nix,
  user,
  config,
  ...
}:
let
  user = config.nixith.user;
in
{
  sops.defaultSopsFile = ../../secrets/services.yaml;
  sops.age.sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
}
