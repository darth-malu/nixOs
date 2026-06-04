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

  boot.kernelParams = [ "intel_pstate=active" ]; # lets cpu use hardware p-states for deep idle

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave"; # 'ondemand', 'perfomance', 'powersave'
  };

  services.thermald.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
