# sudo nix run github:nix-community/disko -- --mode zap_create_mount ./disko-config.nix
{
  disks ? [ "/dev/nvme0n1" ],
  zpoolName ? "darthPool",
  ...
}:
{
  disko.devices = {
    disk = {
      samsungNVME = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "darthPool";
              };
            };
          };
        };
      };
    };
    zpool = {
      ${zpoolName} = {
        type = "zpool";
        rootFsOptions = {
          # https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          mountpoint = "none";
          xattr = "sa";
          # encryption = "on";
          # keyFormat = "passphrase";  #TODO: next time
        };
        options.ashift = "12";

        datasets = {
          # "core" = {
          #   type = "zfs_fs";
          #   options.mountpoint = "none";
          # };
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
            };
            # postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot/local/root@blank$' || zfs snapshot zroot/local/root@blank";
          };
          "root/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            # Used by services.zfs.autoSnapshot options.
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "root/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
              compression = "lz4";
            };
          };
          "root/games" = {
            type = "zfs_fs";
            mountpoint = "/home/games";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "false";
            };
          };
          "root/reserved" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              refreservation = "1G";
            };
          };
          "root/tmp" = {
            type = "zfs_fs";
            options = {
              mountpoint = "/tmp";
            };
          };
          "root/swap" = {
            type = "zfs_volume";
            size = "2G";
            content = {
              type = "swap";
            };
            options = {
              volblocksize = "4096";
              compression = "zle";
              logbias = "throughput";
              sync = "always";
              primarycache = "metadata";
              secondarycache = "none";
              "com.sun:auto-snapshot" = "false";
            };
          };
        };
      };
    };
  };
}
