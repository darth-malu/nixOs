{pkgs, osConfig,...}:

let
  # sample_script = import ./spript.nix {inherit pkgs;};
  songart = import ./songart.nix {inherit pkgs;};
  mpris_vol = import ./mpris_volume_dunst.nix {inherit pkgs;};
  volume_dunst = import ./volume_dunst.nix {inherit pkgs;};
  pause_play = import ./pause_play.nix {inherit pkgs;};
  rofi_power = import ./rofi_power.nix {inherit pkgs;};
  gaps = import ./gaps.nix {inherit pkgs;};
  temp = if osConfig.networking.hostName == "tangier" then import ./temp-tangier.nix {inherit pkgs;} else import ./carthage_temp.nix {inherit pkgs;};
in
{
  home.packages = [
    # sample_script
    songart
    pause_play
    mpris_vol
    volume_dunst
    rofi_power
    gaps
    temp
  ];
}
