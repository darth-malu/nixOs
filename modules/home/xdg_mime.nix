{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations = { 
        added = {
          "text/plain" = [ "nvim.desktop"];
        };
        removed = {

        };
      };

      defaultApplications = {
          #"mimetype1" = [ "default1.desktop" "default2.desktop" ];
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
          "text/html" = [ "google-chrome.desktop" "zen.desktop" "chromium-browser.desktop"];

          "text/plain" = [ "dev.zed.Zed.desktop" "nvim.desktop"];
          "text/pdf" = [ "zathura.desktop"];

          "image/png" = "viewnior.desktop";
          "image/jpeg" = "viewnior.desktop";
          "image/webm" = "viewnior.desktop";
          "image/webp" = "viewnior.desktop";

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
