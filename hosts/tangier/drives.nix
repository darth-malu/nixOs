{
  fileSystems = {
    "/" =
      { device = "darthPool/core/root";
        fsType = "zfs";
      };
    "/home" =
      { device = "darthPool/extra/home";
        fsType = "zfs";
      };

    "/boot" =
      { device = "/dev/disk/by-uuid/D397-96F1";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
  };

  zramSwap.enable = true;
}
     #NOTE: default options: rw, suid, dev, exec, auto, nouser, and async.
     # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
