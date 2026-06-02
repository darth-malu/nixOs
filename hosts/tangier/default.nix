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

  networking = {
    hostName = "tangier"; # Define your hostname.
    # hostId = "92d08a60";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand"; # 'ondemand', 'perfomance', 'powersave'
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
