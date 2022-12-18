let

  nvidia = builtins.getEnv "NVIDIA" != "";
in
{
  videoDrivers = if nvidia then [ nvidia ] else [ ];
  packages = if nvidia then [ nvtop ] else [ ];
}
