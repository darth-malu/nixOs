{ config, lib, ... }:
{
  # zfs, lvm
  fileSystems =
    if config.networking.hostName == "carthage" then
      {

        "/" = {
          device = "darth-pool/root";
          fsType = "zfs";
        };

        "/home" = {
          device = "darth-pool/home";
          fsType = "zfs";
        };

        "/nix" = {
          device = "darth-pool/nix";
          fsType = "zfs";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/9218-D73E";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        "/media/linuxHdd" = {
          device = "/dev/disk/by-uuid/48b59b13-573c-4e39-b2ce-abb2a3c0206e";
          # noCheck = true; # won't mount on boot
          fsType = "ext4";
          options = [
            "users"
            "nofail"
          ]; # defaults if options list missing
        };

        "/media/extraHdd" = {
          device = "/dev/disk/by-uuid/01DA684DD5DAAEA0";
          fsType = "ntfs-3g";
          # noCheck = true;
          options = [
            "rw"
            "uid=1000"
            "users"
            "nofail"
          ];
        };

        "/media/hyogo" = {
          device = "/dev/disk/by-uuid/01DB2D43AC9E5D00";
          fsType = "ntfs-3g";
          options = [
            "users"
            "nofail"
            # "windows_names"
          ];
        };

        "/media/mutsu" = {
          device = "/dev/disk/by-uuid/920E2E2D0E2E0B35";
          fsType = "ntfs-3g";
          options = [
            "users"
            "nofail"
          ];
        };
      }
    else
      {
        # TODO: better control structure for this
        "/" = {
          device = "darthPool/core/root";
          fsType = "zfs";
        };
        "/home" = {
          device = "darthPool/extra/home";
          fsType = "zfs";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/D397-96F1";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

  zramSwap = {
    # TODO: study more on this
    enable = true;
    # memoryPercent = 50;
  };
}

#NOTE: default options: rw, suid, dev, exec, auto, nouser, and async.
# https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
