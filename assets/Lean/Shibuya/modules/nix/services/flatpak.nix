{ pkgs, ... }:
{
  services.flatpak = {
    enable = true;
    package = pkgs.flatpak;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = # make flatpak desktop entries
      ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
  };
}
