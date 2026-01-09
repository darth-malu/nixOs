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
          device = "/dev/disk/by-uuid/68025AB7025A89C8";
          fsType = "ntfs-3g";
          # noCheck = true;
          options = [
            "nofail"
            "defaults"
            "x-systemd.mount-timeout=30" # 90::
            "x-systemd.automount" # only mount upon access
            "x-systemd.idle-timeout=5min"
            # "fmask=133"
            # "dmask=022"
            # "uid=1000"
            # "gid=1000"
          ];
        };

        "/media/kibweziExtraHdd" = {
          device = "/dev/disk/by-uuid/CC74322874321624";
          fsType = "ntfs-3g";
          # noCheck = true;
          options = [
            "nofail"
            "defaults"
            # "fmask=133"
            # "dmask=022"
            # "uid=1000"
            # "gid=1000"
            "x-systemd.mount-timeout=30"
            "x-systemd.automount" # only mount upon access
            "x-systemd.idle-timeout=5min"
            # "windows_names"
          ];
        };

        "/media/Hyogo" = {
          device = "/dev/disk/by-uuid/48b59b13-573c-4e39-b2ce-abb2a3c0206e";
          fsType = "ext4";
          options = [
            "users"
            "nofail"
            "defaults"
            "x-systemd.mount-timeout=30"
          ];
        };

        "/media/Mutsu" = {
          device = "/dev/disk/by-uuid/cc6dc415-697b-4024-945d-6641cf32f5ff";
          fsType = "ext4";
          options = [
            "users"
            "defaults"
            "nofail"
            "x-systemd.mount-timeout=30"
          ];
        };

        # swapDevices = [
        #   {
        #     device = "/dev/disk/by-uuid/910e4778-e884-4cc0-b771-2d9b4868f331";
        #     options = [ "discard" ]; # equivalent to swapon --discard
        #     randomEncryption.enable = true;
        #   }
        # ];
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
    # enable = if config.networking.hostName == "tangier" then true else false;
    enable = true;
    # memoryPercent = 50;
  };

  # services.swapspace.enable = true;
}

#NOTE: default options: rw, suid, dev, exec, auto, nouser, and async.
# https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
