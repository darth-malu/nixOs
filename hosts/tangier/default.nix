{
  config,
  lib,
  ...
}:
{

  imports = [
    ../common
    ./nvidia.nix
  ];

  networking.hostName = "tangier";

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand"; # 'ondemand', 'perfomance', 'powersave'
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
