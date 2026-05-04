{ config, ... }:

{
  fileSystems =
    if config.networking.hostName == "carthage" then
      {

        "/media/Alpha" = {
          device = "/dev/disk/by-uuid/008a7ac5-f0a4-48aa-bda2-8da279fbd11a";
          fsType = "ext4";
          options = [
            "users"
            "nofail"
            "defaults"
            "x-systemd.mount-timeout=30"
            "x-systemd.idle-timeout=20min"
          ];
        };

        "/media/Omega" = {
          device = "/dev/disk/by-uuid/96d58a24-f197-4f96-8409-595aba9431ad";
          fsType = "ext4";
          # noCheck = true;
          options = [
            "users"
            "nofail"
            "defaults"
            "x-systemd.mount-timeout=30"
            "x-systemd.idle-timeout=20min"
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
            "x-systemd.idle-timeout=20min"
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
            "x-systemd.idle-timeout=20min"
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
    enable = true;
    # memoryPercent = 50; 50::
    # writebackDevice = "/dev/sda1";
  };

  # services.swapspace.enable = true; # https://wiki.nixos.org/wiki/Swap

  hardware.usbStorage.manageShutdown = true; # USB storage graceful power off

  services.zfs = {
    autoSnapshot.enable = true; # TODO: see sanoid in man configuration.nix
    autoScrub.enable = true;
    trim.enable = true; # true:: - zpool trim, different from autorim pool property
  };

  boot.zfs.forceImportRoot = false; # NOTE: default^26.11 Forcibly import the ZFS root pool(s) during early boot - data loss mitigation
}

#NOTE: default options: rw, suid, dev, exec, auto, nouser, and async. -> https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
