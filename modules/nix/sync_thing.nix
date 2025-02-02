{
  services = {
    syncthing = {
      enable = true;
      group = "darth";
      user = "malu";
      dataDir = "/home/malu/syncFolder";
      configDir = "/home/malu/Documents/.config/syncthing";
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
      settings = {
        devices = {
          "tangier" = { id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB"; };
          "carthage" = { id = "O2RS6GG-GKU2JYU-D2UEHPV-JQCGHCW-UZKE22D-SMNEYX6-WGAUXLR-BHTLGQA"; };
        };
        folders = {
          "Shibuya" = {         # Name of folder in Syncthing, also the folder ID
            path = "/home/malu/Shibuya";    # Which folder to add to Syncthing
            devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
          };
          "Taskwarrior" = {         # Name of folder in Syncthing, also the folder ID
            path = "/home/malu/.task";    # Which folder to add to Syncthing
            devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
          };
          # "ytVid" = {         # Name of folder in Syncthing, also the folder ID
          #   path = "/home/malu/Videos/YtDlp";    # Which folder to add to Syncthing
          #   devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
          # };
          "music" = {         # Name of folder in Syncthing, also the folder ID
            path = "/home/malu/Music";    # Which folder to add to Syncthing
            devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
            #   ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
        };
        gui = {
          user = "malu";
          password = "password"; #classic lol
        };
      };
    };
  };
}
