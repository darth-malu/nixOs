{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    nvidia-system-monitor-qt
  ];

  # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
  # hardware.enableRedistributableFirmware = true;

  # boot.kernelParams = [ "i915.enable_guc=3" ];

  hardware = {
    intel-gpu-tools.enable = true; # TODO: test for breakages
    graphics = {
      enable = true; # nouveau, opengl
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD (for HD Graphics starting Broadwell (2014) and newer)
        # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium) #NOTE: not source of breakage
        libvdpau-va-gl # vdpau-only apps
        vdpauinfo
      ];
    };

    nvidia.modesetting.enable = true; # required.

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    nvidia.powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    nvidia.powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    nvidia.open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidia.nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

    # laptop optimus prime
    nvidia.prime = {
      # sudo lshw -c display
      sync.enable = false; # gpu on always when true
      offload = {
        # on-demand
        enable = true;
        enableOffloadCmd = true;
        offloadCmdMainProgram = "nvidiaOffload";
      };

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:10:0:0"; # "0a:00.0" # a = 10
    };
  };

  # Load nvidia driver for Xorg and Wayland
  # https://nixos.org/manual/nixos/stable/options#opt-services.xserver.videoDrivers
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # iHD for intel-media-driver (Broadwell+). Use i965 if browser VAAPI issues.
    VDPAU_DRIVER = "va_gl"; # Unnecessary with NVIDIA driver — VDPAU handled natively by nvidia. Only needed for VDPAU-only apps on Intel iGPU.
  };
  # [Intel Graphics - Official NixOS Wiki](https://wiki.nixos.org/wiki/Intel_Graphics)
}
