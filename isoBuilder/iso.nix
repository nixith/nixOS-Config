{ config, pkgs, ... }: {
  environment.systemPackages =
    [ pkgs.neovim pkgs.fish pkgs.git pkgs.tldr pkgs.curl ];

  zramSwap = {
    enable = true;
    memoryPercent = 80;
  };
  # get proper networking
  networking.wireless.enable = pkgs.lib.mkForce false;
  networking.networkmanager.enable = true;
  isoImage.squashfsCompression = "zstd -Xcompression-level 22";
}
