{
  pkgs,
  osConfig,
  ...
}:

let
  mpris_vol = import ./volume/mpris_volume_dunst.nix { inherit pkgs; };
  # pause_play = import ./pause_play.nix { inherit pkgs; };
  gaps = import ./gaps.nix { inherit pkgs; };
  clr_backup = import ./clr_backup.nix { inherit pkgs; };
  backupSumbi = import ./backup/backuper.nix { inherit pkgs; };
  mount_hdd = import ./mount_hdd.nix { inherit pkgs; };
in
{
  home.packages = [
    # pause_play
    mpris_vol
    gaps
    clr_backup
    backupSumbi
  ]
  ++ pkgs.lib.optionals (osConfig.networking.hostName == "carthage") [
    mount_hdd
  ];
}
