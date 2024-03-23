# .nixd.nix
{
  eval = {
    # Example target for writing a package.
    target = {
      args = ["--expr" "with import <nixpkgs> { }; lib.forEach (lib.filesystem.listFilesRecursive ./packages) (x: callPackage x { })"];
      installable = "";
    };
    # Force thunks
    depth = 10;
  };
  formatting.command = "nixpkgs-fmt";
  options = {
    enable = true;
    target = {
      args = [];
      # Example installable for flake-parts, nixos, and home-manager

      # nixOS configuration
      # installable = "/flakeref#nixosConfigurations.<adrastea>.options";

      # home-manager configuration
      installable = ".#homeConfigurations.Galaxia.options";
    };
  };
}
