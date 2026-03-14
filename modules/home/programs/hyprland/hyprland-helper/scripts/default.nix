{
  pkgs,
  osConfig,
  ...
}:

let
  # sample_script = import ./spript.nix {inherit pkgs;};
  songart = import ./songart.nix { inherit pkgs; };
  mpris_vol = import ./volume/mpris_volume_dunst.nix { inherit pkgs; };
  volume_dunst = import ./volume/volume_dunst.nix { inherit pkgs; };
  pause_play = import ./pause_play.nix { inherit pkgs; };
  # rofi_power = import ./rofi_power.nix { inherit pkgs; };
  gaps = import ./gaps.nix { inherit pkgs; };
  # netspeed = import ./netspeed.nix { inherit pkgs; };
  # batteryQS = import ./battery.nix { inherit pkgs; };
  # temp =
  #   if osConfig.networking.hostName == "tangier" then
  #     import ./temp/tangier_temp.nix { inherit pkgs; }
  #   else
  #     import ./temp/carthage_temp.nix { inherit pkgs; };
  clr_backup = import ./clr_backup.nix { inherit pkgs; };
  backupSumbi = import ./backup/backuper.nix { inherit pkgs; };
  mount_hdd = import ./mount_hdd.nix { inherit pkgs; };
in
{
  home.packages =
    pkgs.lib.optionals (osConfig.networking.hostName == "carthage") [
      mount_hdd
    ]
    ++ [
      # netspeed
      songart
      pause_play
      mpris_vol
      volume_dunst
      # rofi_power
      gaps
      # temp
      clr_backup
      backupSumbi
      # batteryQS
    ];
}
