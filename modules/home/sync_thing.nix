{
  services.syncthing = {
    enable = true;
    tray.enable = true;
    settings = {
      gui = {
        user = "maluu";
        password = "maluu";
      };
      # devices = {
      #   "device1" = {};
      #   "device2" = {};
      # };
      folders = {
        "ShibuyaFlake" = {
          path = "/home/malu/Shibuya";
          devices = [ "device1" "device2" ];
          ignorePerms = false; # enable file permissions. default is ignore
        };
      };
    };
  };
}
