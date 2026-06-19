{ config, pkgs, ... }:

let
  mountPoint = "/media/Mutsu";
in
{
  systemd.services."mutsu-mount" = {
    description = "Check if ${mountPoint} is mounted and mount if not";
    after = [ "local-fs.target" ];
    wants = [ "local-fs.target" ];
    script = ''
      if ! mountpoint -q "${mountPoint}"; then
        echo "${mountPoint} is not mounted. Attempting to mount..."
        ${pkgs.systemd}/bin/mount "${mountPoint}"
        if [ $? -eq 0 ]; then
          echo "${mountPoint} mounted successfully."
        else
          echo "Failed to mount ${mountPoint}."
          exit 1
        fi
      else
        echo "${mountPoint} is already mounted."
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      RemainAfterExit = true;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
