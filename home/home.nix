{ nix-colors, overlays, ... }:
let
  username = "ryan";
  homeDirectory = "/home/${username}";
in {

  systemd.user.startServices =
    "sd-switch"; # reload systemd units on config reload

  home = {
    stateVersion = "22.11";

    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "fish";
    };

    inherit username homeDirectory;
  };
  # User Configuration

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    systemDirs = { data = [ "${homeDirectory}/.local/share" ]; };
  };
}
