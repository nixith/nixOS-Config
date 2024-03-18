{
  config,
  pkgs,
  nixpkgs,
  ...
}: {
  imports = [
    (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    (nixpkgs + "/nixos/modules/installer/cd-dvd/channel.nix")
  ];
  environment.systemPackages = [
    pkgs.neovim
    pkgs.fish
    pkgs.git
    pkgs.tldr
    pkgs.curl
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 80;
  };
  networking.networkmanager.enable = true;
  isoImage.squashfsCompression = "zstd -Xcompression-level 22";
}
