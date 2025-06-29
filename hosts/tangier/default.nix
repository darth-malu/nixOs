{config, pkgs, lib, ...}:
{

imports = [
  ../common
  ./nvidia.nix
];

powerManagement.cpuFreqGovernor = lib.mkDefault "powersave"; # TODO: test effects of this, and add to waybar
hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

networking = {
  hostName = "tangier"; # Define your hostname.
  hostId =  "92d08a60";
};
# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
# (the default) this is the recommended approach. When using systemd-networkd it's
# still possible to use this option, but it's recommended to use it in conjunction
# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
# networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

}
