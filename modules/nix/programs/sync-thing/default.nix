{

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

  services.syncthing = {
    # http://127.0.0.1:8384/
    enable = false;
    group = "darth";
    user = "malu";
    openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery. # NOTE unneeded works anyway :) leaving on because.
    # guiAddress = "127.0.0.1:8384";
    systemService = true; # true::
    configDir = "/home/malu/.config/syncthing"; # will run as root if you dont do this by default? (path where the settings and keys will exist)
    dataDir = "/home/malu/syncFolder";
    overrideDevices = true;
    overrideFolders = true; # Whether to delete the folders which are not configured via the folders option
    # key = "${/home/malu/.config/syncthing/key.pem}";
    # cert = "${/home/malu/.config/syncthing/cert.pem}";

    settings = {

      devices = {
        "tangier" = {
          id = "DABGRG2-6ZXSZYX-5P4JOKR-Q3R7ZRC-X7G4S53-FZ44QKA-AAGLFZU-K2GR2QI";
          addresses = [ "tcp://192.168.100.8" ];
        };

        "carthage" = {
          addresses = [ "tcp://192.168.100.5" ];
          id = "DEOOZ33-AWZH56X-4QBF224-QG7LXVY-YXWCGBL-VCWZ3G4-ZWID3ZN-QHBPKQU";
        };

        "SM-J200F" = {
          addresses = [ "tcp://192.168.100.4" ];
          id = "IFCUJMK-HWRR3M5-4MTLSX3-ICLQ344-NEVLLBS-BLFK34N-7VSF3MU-JIQLHA7";

        };
      };

      folders = {

        "sharepoint" = {
          path = "/home/malu/sharepoint";
          devices = [
            "tangier"
            "carthage"
          ];
          minHomeDiskFree = {
            # % (percent of the disk / volume size), kB, MB, GB and TB.
            unit = "%";
            value = 5;
          };
          order = "newestfirst";
        };

      }; # end of folders

      gui = {
        theme = "black";
        user = "malu";
        password = "@syncthing2025";
      };

    }; # end of settings
  }; # end of syncting

}
