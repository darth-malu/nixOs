{ pkgs, ... }:

{
  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true; # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1 This will make xdg-open use the portal to open programs, which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers
    mime = {
      enable = true;
    };
    mimeApps = import ./mime.nix;
    # desktopEntries = import ./desktop-entry.nix;
    userDirs = {
      enable = true;
      createDirectories = false; # false::, Whether to enable automatic creation of the XDG user directories.
      # documents = "${config.home.homeDirectory}/Documents";
      # download = "${config.home.homeDirectory}/Downloads";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/Pictures/grimblast";
      };
    };
    autostart = {
      enable = true;
      readOnly = true; # Make XDG_CONFIG_HOME/autostart a symlink to a readonly directory so that programs cannot install arbitrary autostart services.
      entries = [
        "${pkgs.qbittorrent}/share/applications/org.qbittorrent.qBittorrent.desktop"
      ];
    };
  };
}
