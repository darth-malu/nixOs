{
 # systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

 services.syncthing = {
   # http://127.0.0.1:8384/
   # allProxy = "socks5://address.com:1234";
   enable = true;
   # guiAddress = "127.0.0.1:8384";
   configDir = "/home/malu/.config/syncthing"; # will run as root if you dont do this by default? (path where the settings and keys will exist)
   dataDir = "/home/malu/syncFolder";
   overrideDevices = true;
   overrideFolders = true; # Whether to delete the folders which are not configured via the folders option
   tray = true;
   passwordFile = ./syncPass

settings = {

devices = {
  "tangier" = {
    id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB";
    name = "Hp laptop"
  };

  "carthage" = {
    name = "Custom pc"
    id = "DEOOZ33-AWZH56X-4QBF224-QG7LXVY-YXWCGBL-VCWZ3G4-ZWID3ZN-QHBPKQU";
  };
};

folders = {
  "Shibuya" = {         # Name of folder in Syncthing, also the folder ID
    enable = true;
    path = "/home/malu/Shibuya";    # Which folder to add to Syncthing
    devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
    # copyOwnershipFromParent = "true";
    # versioning.type = ""
  };

"ytVid" = {
  path = "/home/malu/Videos/YtDlp";
  devices = [ "carthage" ]; # device to receive from?
  type = "receiveonly"; # sendreceive::,sendonly, receiveonly, receiveencrypted
  order = "newestFirst"; # random(default), alphabetic, smallestFirst, largestFirst,
  # versioning = {
  #   type = "staggered";
  #   fsPath = "/syncthing/backup";
  #   params = {
  #     cleanInterval = "3600";
  #     maxAge = "31536000";
  #   };
  # };
};

"music" = {
  path = "/home/malu/Music/homeMusic";
  devices = ["tangier"];
  type = "receiveonly";
  minHomeDiskFree = {
    # % (percent of the disk / volume size), kB, MB, GB and TB.
    unit = "%";
    value = 10;
  };
};

"ncmpcpp_playlists" = {
  path = "/home/malu/Music/ncmpcppStuff/playlists";
  devices = ["tangier" "carthage"];
  type = "sendreceive";
};

  "myVaults" = {
    path = "/home/malu/obsidianVaults";
    devices = ["tangier" "carthage"];
  };

  "sharepoint" = {
    path = "/home/malu/sharepoint";
    devices = ["tangier" "carthage"];
  };

"org" = {
  path = "/home/malu/org";
  devices = ["tangier" "carthage"];
};

"org-roam" = {
  path = "/home/malu/org-roam";
  devices = ["tangier" "carthage"];
};
}; # end of folders

    }; # end of settings
};

}
