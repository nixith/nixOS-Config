{ sops-nix, user, ... }: {
  sops.defaultSopsFile = ../../secrets/services.yaml;
  sops.age.sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
}
