{ config }:
{
  imports = [
    # ./desktop-entry.nix
    # ./mime.nix
  ];

  xdg = {
    enable = true;
    portal.xdgOpenUsePortal = true; # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1 This will make xdg-open use the portal to open programs, which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers
    mimeApps = import ./mime.nix;
    # desktopEntries = import ./desktop-entry.nix;
    userDirs = import ./userDirs.nix;
  };
}
