{
  disko.devices = {
    disk = {
      main =
        let
          dev = "/dev/nvme0n1";
        in

        {
          type = "disk";
          device = dev;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                  ];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  # disable settings.keyFile if you want to use interactive password entry
                  passwordFile = "/tmp/secret.key"; # Interactive
                  settings = {
                    allowDiscards = true;
                    #keyFile = "/tmp/secret.key";
                  };
                  #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [ "compress=zstd" ];
                      };
                      "/home" = {
                        mountpoint = "/";
                        mountOptions = [ "compress=zstd" ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      # "/swap" = {
                      #   mountpoint = "/.swapvol";
                      #   swap.swapfile.size = "16G";
                      # };
                    };
                  };
                };
              };
            };
          };
        };
    };
  };
}
