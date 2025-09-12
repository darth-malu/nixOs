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
  overrideDevices = true;
  overrideFolders = true; # Whether to delete the folders which are not configured via the folders option
  # key = "${/home/malu/.config/syncthing/key.pem}";
  # cert = "${/home/malu/.config/syncthing/cert.pem}";

settings = {

devices = {
  "tangier" = {
    id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB";
    addresses = ["tcp://192.168.100.8"];
  };

  "carthage" = {
    addresses = ["tcp://192.168.100.5"];
    id = "DEOOZ33-AWZH56X-4QBF224-QG7LXVY-YXWCGBL-VCWZ3G4-ZWID3ZN-QHBPKQU";
  };
};

"ytVid-tangier" = {
  path = "/home/malu/Videos/YtDlp";
  devices = [ "tangier" ]; # send to device listed here
  type = "sendonly"; # sendreceive::,sendonly, receiveonly, receiveencrypted
  order = "newestFirst"; # random(default), alphabetic, smallestFirst, largestFirst,
  # maxConflicts = 2; # -1:: unlimited number , 0 - disables
  maxConcurrentWrites = 4; # 2:: Maximum number of concurrent write operations while syncing. Increasing this might increase or decrease disk performance, depending on the underlying storage.
  # scanProgressIntervalS = 0; # The interval in seconds with which scan progress information is sent to the GUI. Setting to 0 will cause Syncthing to use the default value of two.
};

"ytVid-carthage" = {
  path = "/home/malu/Videos/YtDlp";
  devices = [ "carthage" ];
  type = "receiveonly";
  order = "newestFirst";
  maxConcurrentWrites = 4;
  minHomeDiskFree = {
    # % (percent of the disk / volume size), kB, MB, GB and TB.
    unit = "%";
    value = 15;
  };
};

"ncmpcpp_playlists" = {
  path = "/home/malu/Music/ncmpcpp/playlists";
  devices = ["tangier" "carthage"];
  type = "sendreceive";
};

  "sharepoint" = {
    path = "/home/malu/sharepoint";
    devices = ["tangier" "carthage"];
  };

gui = {
  theme = "black";
  user = "malu";
  password = "@syncthing2025";
};

}; # end of settings
 }; # end of syncting

}
