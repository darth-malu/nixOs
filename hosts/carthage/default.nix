{lib, config,...}:

{

imports = [
  ./amd.nix
  ../common
  ../common/users/remote-builder.nix # removed from common only for carthage now
];

hardware = {
  cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # enableAllFirmware = true; # enable all firmware regardless of license #for bt to work in HSP/HFP mode
  # enableAllHardware = true; # Enable support for most hardware
};

networking = {
  hostName = "carthage";
  hostId = "7435d550";
};

}
