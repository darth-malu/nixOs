{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true; #false::
      associations = { # as if the .desktop file was listing this mimetype in the first place
        added = {
          "text/plain" = [ "nvim.desktop"];
        };
        removed = { # as if the .desktop file was not listing this mimetype in the first place

        };
      };

      defaultApplications = {
          #"mimetype1" = [ "default1.desktop" "default2.desktop" ];
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
          "text/html" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];

          "text/plain" = [ "dev.zed.Zed.desktop" "nvim.desktop"];
          "text/pdf" = [ "zathura.desktop"];

          "image/png" = [ "viewnior.desktop" ]; # add logic to check for x11
          "image/jpeg" = [ "viewnior.desktop" ]; # imv.desktop
          "image/webm" = [ "viewnior.desktop" ];
          "image/webp" = [ "viewnior.desktop" ];

          "application/pdf" = "org.pwmt.zathura.desktop";

          "inode/directory" = [ "yazi.desktop" "org.gnome.Nautilus.desktop" ];

          "x-scheme-handler/http" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];

          "x-scheme-handler/https" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];
          "x-scheme-handler/about" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];
          "x-scheme-handler/unknown" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];
      };
    };
  };
}
