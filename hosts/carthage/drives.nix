{
  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/d0c435ce-b5d0-44c0-9ac4-88b67734756b";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/3eea7486-62a4-455c-a686-7f28f5e9b118";
      fsType = "ext4";
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
      #noCheck = true;
      fsType = "ext4";
      options = [#defaults if options list missing
        #"users"
        "users"
        "nofail"
      ];
    };

    "/media/extraHdd" = {
      device = "/dev/disk/by-uuid/01DA684DD5DAAEA0";
      fsType = "ntfs-3g";
      options = [
        "users"
        # "noauto"
        "nofail"
        # "defaults"
        # "fmask=0022"
        # "dmask=0022"
        # "uid=1000"
        # "rw"
        # "noauto"
        # "windows_names"
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
  };

  swapDevices = [
    {
      device = "/.darthswapfile";
      size = 2 * 1024; # 2GB
    }
  ];
}
     #NOTE: default options: rw, suid, dev, exec, auto, nouser, and async.
     # https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
