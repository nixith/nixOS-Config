{
  modulesPath,
  ...
}:
{
  imports = [ "${modulesPath}/profiles/perlless.nix" ];
  system.nixos-init.enable = true;
}
