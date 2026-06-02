{ config, ... }:

{
 # fileSystems =
            # swapDevices = [
        #   {
        #     device = "/dev/disk/by-uuid/910e4778-e884-4cc0-b771-2d9b4868f331";
        #     options = [ "discard" ]; # equivalent to swapon --discard
        #     randomEncryption.enable = true;
        #   }
        # ];
#;
  zramSwap = {
    enable = true;
    # memoryPercent = 50; 50::
    # writebackDevice = "/dev/sda1";
  };

  # services.swapspace.enable = true; # https://wiki.nixos.org/wiki/Swap

  hardware.usbStorage.manageShutdown = true; # USB storage graceful power off

}

#NOTE: default options: rw, suid, dev, exec, auto, nouser, and async. -> https://manpages.ubuntu.com/manpages/noble/en/man8/mount.8.html#filesystem-independent%20mount%20options
