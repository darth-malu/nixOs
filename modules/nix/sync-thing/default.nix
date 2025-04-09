{
 systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

 services.syncthing = {
   # http://127.0.0.1:8384/
   enable = true;
   group = "darth";
   user = "malu";
   openDefaultPorts = true; # TCP/UDP 22000 for transfers and UDP 21027 for discovery. # NOTE unneeded works anyway :) leaving on because.
   # guiAddress = "127.0.0.1:8384";
   systemService = true; # true::
   configDir = "/home/malu/.config/syncthing"; # will run as root if you dont do this by default? (path where the settings and keys will exist)
   dataDir = "/home/malu/syncFolder";
   overrideDevices = false;
   overrideFolders = false; # Whether to delete the folders which are not configured via the folders option
   # key = "${/home/malu/.config/syncthing/key.pem}";
   # cert = "${/home/malu/.config/syncthing/cert.pem}";

settings = {

devices = {
  "tangier" = {
    id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB";
  };
  "carthage" = {
    # id = "O2RS6GG-GKU2JYU-D2UEHPV-JQCGHCW-UZKE22D-SMNEYX6-WGAUXLR-BHTLGQA";
    id = "6BCT57I-VW3QQGE-HBEAZGA-UHFTPH4-RBF6R2H-EN33IXQ-HPVOPGG-2NQHOAD";
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

<<<<<<< HEAD
  # "ytVid" = {
  #   path = "/home/malu/Videos/YtDlp";
  #   devices = [ "tangier" ]; # device to receive from?
  #   type = "receiveonly"; # sendreceive::,sendonly, receiveonly, receiveencrypted
  #   order = "newestFirst"; # random(default), alphabetic, smallestFirst, largestFirst,
  #   # maxConflicts = 2; # -1:: unlimited number , 0 - disables
  #   maxConcurrentWrites = 4; # 2:: Maximum number of concurrent write operations while syncing. Increasing this might increase or decrease disk performance, depending on the underlying storage.
  #   # scanProgressIntervalS = 0; # The interval in seconds with which scan progress information is sent to the GUI. Setting to 0 will cause Syncthing to use the default value of two.
  #   minHomeDiskFree = {
  #     # % (percent of the disk / volume size), kB, MB, GB and TB.
  #     unit = "%";
  #     value = 15;
  #   };
  # };
=======
  "ytVid" = {
    path = "/home/malu/Videos/YtDlp";
    devices = [ "carthage" ];
    type = "receiveonly"; # sendreceive::,sendonly, receiveonly, receiveencrypted
    order = "newestFirst"; # random(default), alphabetic, smallestFirst, largestFirst,
    # maxConflicts = 2; # -1:: unlimited number , 0 - disables
    maxConcurrentWrites = 4; # 2:: Maximum number of concurrent write operations while syncing. Increasing this might increase or decrease disk performance, depending on the underlying storage.
    # scanProgressIntervalS = 0; # The interval in seconds with which scan progress information is sent to the GUI. Setting to 0 will cause Syncthing to use the default value of two.
    minHomeDiskFree = {
      # % (percent of the disk / volume size), kB, MB, GB and TB.
      unit = "%";
      value = 15;
    };
  };
>>>>>>> 9e29ecd (plugins only for tangier)

  "music" = {
    path = "/home/malu/Music";
    devices = [
      "tangier"
      "carthage"
    ];
    type = "sendreceive";
    # minHomeDiskFree = {
    #   # % (percent of the disk / volume size), kB, MB, GB and TB.
    #   unit = "%";
    #   value = 40;
    # };
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
}; # end of folders

gui = {
  theme = "black";
  user = "malu";
  password = "@syncthing2025";
};

};
 };
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
