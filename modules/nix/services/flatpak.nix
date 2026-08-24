{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.nix-flatpak}/modules/nixos.nix"
  ];
  services.flatpak = {
    enable = true;
    package = pkgs.flatpak;
    packages = [
      # "com.vixalien.sticky"
    ];
  };

  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = # make flatpak desktop entries
  #     ''
  #       flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #     '';
  # };

  /*
    To delete an application with its data
    declarative - flatpak uninstall --unused --delete-data #to both delete all leftover applications and wipe the data of anything previously deleted
    imperative - flatpak uninstall <application> --delete-data
  */
}
