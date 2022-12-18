let

  nvidia = builtins.getEnv "NVIDIA" != "";
in
{
  videoDrivers = if nvidia then [ nvidia ] else [ ];
  packages = with pkgs ; if nvidia then [ nvtop ] else [ btop ];
}
