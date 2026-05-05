{
  pkgs,
  config,
  lib,
  ...
}:
# https://wiki.nixos.org/wiki/Linux_kernel
{

  boot.kernel.sysctl."kernel.sysrq" = 1;

  boot.kernelPackages = pkgs.linuxPackages_7_0;

  boot.plymouth.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.loader = {
    systemd-boot = {
      enable = true;
      # editor = false; # true:: allow editing kernel commandline before boot
      # windows
      # sortKey = "nixos"; #https://uapi-group.org/specifications/specs/boot_loader_specification/#sorting
    };
    efi.canTouchEfiVariables = true;
    timeout = 2;
  };
  boot.initrd.kernelModules =
    if config.networking.hostName == "carthage" then
      [
        # "dm-snapshot"               # lvm
        # "amdgpu"
      ]
    else
      [ ];
  boot.initrd.availableKernelModules =
    if config.networking.hostName == "carthage" then
      [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ]
    else
      [
        "xhci_pci" # usb 3.0
        "ehci_pci" # usb 2.0
        "ahci" # sata
        "usb_storage" # usb mass storage devices - hdd, flash
        "sd_mod" # scsi device and some sata
        "sr_mod" # cd drive
      ];
  boot.initrd.systemd.network = {
    enable = false;
    wait-online.enable = false; # since using networkmanager not networkd;
  };
  boot.kernelModules =
    lib.optionals (config.networking.hostName == "tangier") [
      "kvm-intel"
    ]
    ++ lib.optionals (config.networking.hostName == "carthage") [
      "kvm-amd"
    ]
    ++ [
      "wl" # broadcomm closed source
    ];

  # boot.kernelParams can be set to supply the Linux kernel with additional command line arguments at boot time. It can only be used for built-in modules.
  boot.kernelParams = [
    # parameterrs for kernel command line
    #   "video=HDMI-A-1:1920x1080@240"
    #   "video=DP-3:1920x1080@60"
    "nohibernate" # because zfs
  ];

  # boot.extraModprobeConfig = ''
  #   # example settings
  #   options yourmodulename optionA=valueA optionB=valueB # syntax
  #   options thinkpad_acpi  fan_control=1                 # example #1 kernel module parameter
  #   options usbcore        blinkenlights=1               # example #2 kernel module parameter
  # '';

}
