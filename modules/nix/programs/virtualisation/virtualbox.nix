{
  virtualbox = {
    guest.enable = false;
    host = {
      enable = false;
      enableExtensionPack = false; # usb2/3 forward to guests #NOTE: frequent recompilation with host extensions
      # enableKvm = true; # better compat with linux kernel versions
      # addNetworkInterface = true; # true:: -vboxnet0
    };
  };
}
