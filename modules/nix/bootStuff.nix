{ pkgs, ... }:
# https://wiki.nixos.org/wiki/Linux_kernel
{
  boot = {
    kernelPackages = pkgs.linuxPackages_7_0;
    # extraModprobeConfig =  ''
    #  kernelParams = [
    #   # example settings
    #   "quiet"
    #   "splash"
    #   # example kernel module parameter
    #   "usbcore.blinkenlights=1"
    # ];   # '';
  };
  # boot.kernelParams can be set to supply the Linux kernel with additional command line arguments at boot time. It can only be used for built-in modules.
}
