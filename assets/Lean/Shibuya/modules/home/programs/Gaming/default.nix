{ osConfig, lib, ... }:

{
  imports = [
    ./lutris.nix
    ./mangohud.nix
  ];

  lutris-malu.enable = lib.mkIf (osConfig.networking.hostName == "carthage") true;
  mangohud.enable = lib.mkIf (osConfig.networking.hostName == "carthage") true;
}
