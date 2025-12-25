{
  enable = true; # false::
  associations = {
    # as if the .desktop file was listing this mimetype in the first place
    added = {
      # "text/plain" = [ "nvim.desktop" ];
    };
    removed = {
      # as if the .desktop file was not listing this mimetype in the first place
      "video/mp4" = "fr.handbrake.ghb.desktop";
      "video/x-matroska" = "fr.handbrake.ghb.desktop";
      "audio/mp3" = [
        "mpv.desktop"
        "umpv.desktop"
      ];
    };
  };

  defaultApplications = {
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];

    "text/html" = [
      "google-chrome.desktop"
      "chromium-browser.desktop"
      "firefox.desktop"
      "zen.desktop"
    ];

    "text/plain" = [
      "emacsclient.desktop"
      "dev.zed.Zed.desktop"
      "vim.desktop"
    ];

    "text/pdf" = [
      "zathura.desktop"
      "emacsclient.desktop"
    ];

    "application/pdf" = [
      "org.pwmt.zathura.desktop"
      "emacsclient.desktop"
    ];

    "text/x-script.python;" = [ "emacsclient.desktop" ];

    "image/png" = [ "viewnior.desktop" ]; # add logic to check for x11
    "image/jpeg" = [ "viewnior.desktop" ]; # imv.desktop
    "image/webm" = [ "viewnior.desktop" ];
    "image/webp" = [ "viewnior.desktop" ];

    "audio/mpeg" = [ "mpv.desktop" ];
    "video/mp4" = [ "mpv.desktop" ];
    "video/x-matroska" = [ "mpv.desktop" ];

    "inode/directory" = [
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
