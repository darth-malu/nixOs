{ config, ... }:

{
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

        "/media/kibweziC" = {
          # /dev/sda3 - c drive
          device = "/dev/disk/by-uuid/68025AB7025A89C8";
          fsType = "ntfs-3g";
          noCheck = true;
          options = [
            "users"
            "nofail"
          ];
        };

        "/media/kibweziExtraHdd" = {
          # /dev/sda5 - extraHdd
          device = "/dev/disk/by-uuid/CC74322874321624";
          fsType = "ntfs-3g";
          noCheck = true;
          options = [
            "users"
            "nofail"
            # "windows_names"
          ];
        };

        "/media/Hyogo" = {
          device = "/dev/disk/by-uuid/48b59b13-573c-4e39-b2ce-abb2a3c0206e";
          fsType = "ext4";
          options = [
            "users"
            "nofail"
          ];
        };

        "/media/Mutsu" = {
          device = "/dev/disk/by-uuid/cc6dc415-697b-4024-945d-6641cf32f5ff";
          fsType = "ext4";
          options = [
            "users"
            "nofail"
          ];
        };
      }
    else
      {
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
