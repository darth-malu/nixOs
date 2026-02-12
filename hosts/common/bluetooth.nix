{
  programs.bluetuith = {
    enable = true;
    settings = {
      adapter = "hci0";
      receive-dir = "/home/malu/BluetoothTransfers";

      keybindings = {
        Menu = "Alt+m";
      };

      theme = {
        Adapter = "red";
      };
    };
  };

  hardware = {
    # enableAllFirmware = true; # enable all firmware regardless of license
    # enableAllHardware = true; # Enable support for most hardware
    enableRedistributableFirmware = true; # enable firmware with a license allowing redistribution
    bluetooth = {
      # hsphfpd.enable = true; # support for hsphfpd[-prototype] implementation.NOTE: might be old? and conflicting
      enable = true;
      powerOnBoot = true; # power on default controller on boot
      settings = {
        # Set configuration for system-wide bluetooth (/etc/bluetooth/main.conf). See https://github.com/bluez/bluez/blob/master/src/main.conf for full list of options.
        General = {
          Experimental = true; # battery %
          # ControllerMode = "bredr";
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
