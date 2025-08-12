{ pkgs-unstable, ... }:
{
  services.flatpak = {
    enable = true;
    package = pkgs-unstable.flatpak;
  };
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs-unstable.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
