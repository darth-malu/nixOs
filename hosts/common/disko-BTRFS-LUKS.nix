{
  disks ? [
    "/dev/nvme0n1"
    "/dev/sda"
  ],
  config,
  ...
}:

{
  disko.devices = {
    disk = {
      BtrfsDevice = {
        type = "disk";
        device =
          if config.networking.hostName == "carthage" then
            builtins.elemAt disks 0
          else
            builtins.elemAt disks 1;
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
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "800G";
              content = {
                type = "luks";
                name = "GoodLuks";
                # disable settings.keyFile if you want to use interactive password entry
                # passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  # keyFile = "/tmp/secret.key";
                };
                # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "-L"
                    "nixos"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        # "subvol=root"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                        # "subvol=home"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    # "/log" = {
                    #   mountpoint = "/var/log";
                    #   mountOptions = [
                    #     "subvol=log"
                    #     "compress=zstd"
                    #     "noatime"
                    #   ];
                    # };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      mountOptions = [
                        "noatime"
                        "nodatacow"
                        "compress=no"
                      ];
                      swap.swapfile.size = "32G";
                    };
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
