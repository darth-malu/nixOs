# TODO: see if transition to btrfs is worth it (Not fully utilizing ZFS + higher ram usage - No on the fly changes)
# sudo nix run github:nix-community/disko -- --mode zap_create_mount ./disko-config.nix
{
  disks ? [
    "/dev/nvme0n1"
    "/dev/sda"
  ],
  config,
  ...
}:
let
  rootCommon = {
    size = "100%";
    content = {
      type = "btrfs";
      extraArgs = [ "-f" ]; # Override existing partition
      # Subvolumes must set a mountpoint in order to be mounted,
      # unless their parent is mounted
      subvolumes = {
        # Subvolume name is different from mountpoint
        "/rootfs" = {
          mountpoint = "/";
        };
        # Subvolume name is the same as the mountpoint
        "/home" = {
          mountOptions = [ "compress=zstd" ];
          mountpoint = "/home";
        };
        # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
        "/home/malu" = { };
        # Parent is not mounted so the mountpoint must be set
        "/nix" = {
          mountOptions = [
            "compress=zstd"
            "noatime"
          ];
          mountpoint = "/nix";
        };
        # This subvolume will be created but not mounted
        # "/test" = { };
        "/swap" = {
          mountpoint = "/.swapvol";
          swap = {
            swapfile.size = "20M";
            swapfile2.size = "20M";
            swapfile2.path = "rel-path";
          };
        };
      };

      mountpoint = "/partition-root";
      swap = {
        swapfile = {
          size = "20M";
        };
        swapfile1 = {
          size = "20M";
        };
      };
    };
  };
in
{
  disko.devices =
    if config.networking.hostName == "carthage" then
      {
        disk = {
          samsungNVME = {
            device = builtins.elemAt disks 0;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  name = "ESP";
                  type = "EF00";
                  size = "200M";
                  # start = "1MiB";
                  # end = "200MiB";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = rootCommon;
              };
            };
          };
        };
      }
    else
      {
        disk = {
          samsungSATA = {
            device = builtins.elemAt disks 1;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  name = "ESP";
                  type = "EF00";
                  size = "200M";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = rootCommon;
              };
            };
          };
        };
      };
}
