{ ... }: {
  sops = {
    age.sshKeyPaths = [ "/home/ryan/.ssh/id_ed25519" ];
    defaultSopsFile = ../../secrets/services.yaml;
  };
}
