{
  services = {
    syncthing = {
      enable = true;
      group = "darth";
      user = "malu";
      dataDir = "/home/malu/syncFolder";
      configDir = "/home/malu/Documents/.config/syncthing";
      overrideDevices = false;     # overrides any devices added or deleted through the WebUI
      overrideFolders = false;
      settings = {
        devices = {
          "tangier" = { id = "RIYCPC3-U3UCO5N-WLM7WNB-5372SAE-RSGUD4Y-BFIWCUC-WPOII3S-N2EGNAB"; };
          "carthage" = { id = "O2RS6GG-GKU2JYU-D2UEHPV-JQCGHCW-UZKE22D-SMNEYX6-WGAUXLR-BHTLGQA"; };
        };
        folders = {
          # "Shibuya" = {         # Name of folder in Syncthing, also the folder ID
          #   path = "/home/malu/Shibuya";    # Which folder to add to Syncthing
          #   devices = [ "tangier" "carthage" ];      # Which devices to share the folder with
          #   ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          # };
          "Taskwarrior" = {
            path = "/home/malu/.task";
            devices = [ "tangier" "carthage" ];
          };
          "ytVid" = {
            path = "/home/malu/Videos/YtDlp";
            devices = [ "tangier" "carthage" ];
          };
          "music" = {
            path = "/home/malu/Music";
            devices = [ "tangier" "carthage" ];
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
