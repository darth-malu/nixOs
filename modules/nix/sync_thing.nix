{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services = {
    syncthing = {
      # http://127.0.0.1:8384/
      enable = true;
      group = "darth";
      user = "malu";
      openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery. # NOTE unneeded works anyway :) leaving on because.
      guiAddress = "127.0.0.1:8384";
      systemService = true; # true::
      configDir = "/home/malu/.config/syncthing"; # will run as root if you dont do this by default? not nice for dots ... videos :)
      dataDir = "/home/malu/syncFolder";
      overrideDevices = false;
      overrideFolders = false; # Whether to delete the folders which are not configured via the folders option
      settings = {
        devices = {
          "tangier" = {
            id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB";
          };
          "carthage" = {
            id = "O2RS6GG-GKU2JYU-D2UEHPV-JQCGHCW-UZKE22D-SMNEYX6-WGAUXLR-BHTLGQA";
          };
        };
        folders = {
          # "Shibuya" = {         # Name of folder in Syncthing, also the folder ID
          #   path = "/home/malu/Shibuya";    # Which folder to add to Syncthing
          #   devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
          # };
          "Taskwarrior" = {
            path = "/home/malu/.task";
            devices = [
              "tangier"
              "carthage"
            ];
            type = "sendreceive";
          };
          "ytVid" = {
            path = "/home/malu/Videos/YtDlp";
            devices = [ "carthage" ];
            type = "receiveonly"; # sendreceive::,sendonly, receiveonly, receiveencrypted
            order = "newestFirst"; # random(default), alphabetic, smallestFirst, largestFirst,
            # maxConflicts = 2; # -1:: unlimited number , 0 - disables
            maxConcurrentWrites = 4; # Maximum number of concurrent write operations while syncing. Increasing this might increase or decrease disk performance, depending on the underlying storage. Default is 2.
            # scanProgressIntervalS = 0; # The interval in seconds with which scan progress information is sent to the GUI. Setting to 0 will cause Syncthing to use the default value of two.
            minHomeDiskFree = {
              # % (percent of the disk / volume size), kB, MB, GB and TB.
              unit = "%";
              value = 10;
            };
          };
          "music" = {
            path = "/home/malu/Music";
            devices = [
              "tangier"
              "carthage"
            ];
            minHomeDiskFree = {
              # % (percent of the disk / volume size), kB, MB, GB and TB.
              unit = "%";
              value = 10;
            };
          };
          "myVaults" = {
            path = "/home/malu/obsidianVaults";
            devices = [
              "tangier"
              "carthage"
            ];
          };
          "org" = {
            path = "/home/malu/org";
            devices = [
              "tangier"
              "carthage"
            ];
          };
          "org-roam" = {
            path = "/home/malu/org-roam";
            devices = [
              "tangier"
              "carthage"
            ];
          };
        };
        gui = {
          theme = "black";
          user = "malu";
          password = "@syncthing2025";
        };
      };
    };
  };
}
