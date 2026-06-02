{
  hardware = {
    # enableAllFirmware = true; # enable all firmware regardless of license - no audio HSP/HFP mode
    # enableAllHardware = true; # Enable support for most hardware
    enableRedistributableFirmware = false; # enable firmware with a license allowing redistribution
    bluetooth = {
      # hsphfpd.enable = true; # support for hsphfpd[-prototype] implementation.NOTE: might be old? and conflicting
      enable = true;
      powerOnBoot = true; # power on default controller on boot
      settings = {
        # Set configuration for system-wide bluetooth (/etc/bluetooth/main.conf). See https://github.com/bluez/bluez/blob/master/src/main.conf for full list of options.
        General = {
          Experimental = true; # battery %
          # ControllerMode = "bredr"; # dual::(BR/EDR and LE enabled.), "bredr"-old,  "le"
          FastConnectable = true; # scan for incoming connections more frequently - increased power
          # JustWorksRepairing = "never"; # never::, confirm, always
          # Class = "0x000100"; # how pc ids itself ie. as computer to other devices 0x000000::
          # name = "DarthBluez"; # default adaptere name- default is Bluez X.YZ
        };
      };
      # package = pkgs.bluez;
      # network = {
      #     General = {
      #       DisableSecurity = false; # Disable link encryption: default=false
      #     };
      # };
      # input = {#Set configuration for the input service (/etc/bluetooth/input.conf). See https://github.com/bluez/bluez/blob/master/profiles/input/input.conf for full list of options.
      # General = {
      # ClassicBondedOnly = false; #true:: # # Limit HID connections to bonded devices
      # IdleTimeout = 30;# 0 (disabled)::
      #UserspaceHID=true; #true:: # # Enable HID protocol handling in userspace input profile - true,false, persist
      #LEAutoSecurity=true; # true::
      # };
      # };
    };
  };
}
