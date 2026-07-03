{ config, ... }:

{

  swapDevices = [
    {
      device = "/.swapvol/swapfile";
      size = if config.networking.hostName == "tangier" then 16 * 1024 else 32 * 1024; # in MB
      options = [ "discard" ];
    }
  ];
  fileSystems =
    if config.networking.hostName == "carthage" then
      {
        "/media/Hyogo" = {
          device = "/dev/disk/by-uuid/48b59b13-573c-4e39-b2ce-abb2a3c0206e";
          fsType = "ext4";
          options = [
            "users"
            "nofail"
            "defaults"
            # "x-systemd.mount-timeout=30"
            # "x-systemd.idle-timeout=20min"
          ];
        };

        "/media/Mutsu" = {
          device = "/dev/disk/by-uuid/cc6dc415-697b-4024-945d-6641cf32f5ff";
          fsType = "ext4";
          options = [
            "users"
            "defaults"
            "nofail"
            # "x-systemd.mount-timeout=30"
            # "x-systemd.idle-timeout=20min"
          ];
        };

        "/media/Yuri" = {
          device = "/dev/disk/by-uuid/07b5529b-889a-4567-ba75-bbc738c23219";
          fsType = "ext4";
          options = [
            "users"
            "defaults"
            "nofail"
          ];
        };
      }
    else
      { };

  zramSwap = {
    enable = false;
    # memoryPercent = 50; 50::
    # writebackDevice = "/dev/sda1";
  };

  # services.swapspace.enable = true; # https://wiki.nixos.org/wiki/Swap

  hardware.usbStorage.manageShutdown = true; # USB storage graceful power off

  services.btrfs = {
    autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };
  };

  # services.zfs = {
  #   autoSnapshot.enable = true; # TODO: see sanoid in man configuration.nix
  #   autoScrub.enable = true;
  #   trim.enable = true; # true:: - zpool trim, different from autorim pool property
  # };

  # boot.zfs.forceImportRoot = false; # NOTE: default^26.11 Forcibly import the ZFS root pool(s) during early boot - data loss mitigation
}

#NOTE: default options: rw, suid, dev, exec, auto, nouser, and async. -> https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
