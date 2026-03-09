{lib, config,...}:

{

imports = [
  ./amd.nix
  ../common
];

hardware = {
  cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};

networking = {
  hostName = "carthage";
  hostId = "7435d550";
};

  networking.firewall = {
    allowedTCPPorts = [ 3216 3389 8806];
    # allowedTCPPortRanges = [
    #   {
    #     from = 1714;
    #     to = 1764;
    #   }
    # ];
    # allowedUDPPortRanges = allowedTCPPortRanges;
  };

}
