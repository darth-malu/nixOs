{
  enable = true; # false::
  associations = {
    # as if the .desktop file was listing this mimetype in the first place
    added = {
      # "text/plain" = [ "nvim.desktop" ];
    };
    removed = {
      # as if the .desktop file was not listing this mimetype in the first place
    };
  };

  defaultApplications = {
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];

    "text/html" = [
      "google-chrome.desktop"
      "zen.desktop"
      "chromium-browser.desktop"
    ];

    "text/plain" = [
      "emacsclient.desktop"
      "dev.zed.Zed.desktop"
      # "nvim.desktop"
    ];

    "text/pdf" = [
      "emacsclient.desktop"
      "zathura.desktop"
    ];

    "application/pdf" = [
      "emacsclient.desktop"
      "org.pwmt.zathura.desktop"
    ];

    "text/x-script.python;" = [ "emacsclient.desktop" ];

    "image/png" = [ "viewnior.desktop" ]; # add logic to check for x11
    "image/jpeg" = [ "viewnior.desktop" ]; # imv.desktop
    "image/webm" = [ "viewnior.desktop" ];
    "image/webp" = [ "viewnior.desktop" ];

    "audio/mpeg" = [ "mpv.desktop" ];

    "inode/directory" = [
      "org.kde.Dolphin.desktop"
      "yazi.desktop"
      "org.gnome.Nautilus.desktop"
    ];

    "x-scheme-handler/http" = [
      "google-chrome.desktop"
      "chromium-browser.desktop"
    ];

    "x-scheme-handler/https" = [
      "google-chrome.desktop"
      "chromium-browser.desktop"
    ];
    "x-scheme-handler/about" = [
      "google-chrome.desktop"
      "chromium-browser.desktop"
    ];
    "x-scheme-handler/unknown" = [
      "google-chrome.desktop"
      "chromium-browser.desktop"
    ];
  };
}
