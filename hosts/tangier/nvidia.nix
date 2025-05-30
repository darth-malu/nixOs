{ config, ... }:

{
  nixpkgs.config.allowUnfree = true; # temporarily
  hardware = {
    graphics = {
      enable = true; # opengl?
    };

    nvidia.modesetting.enable = true; # required.

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    nvidia.powerManagement.enable = false;

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
    nvidia.nvidiaSettings = false;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    # laptop optimus prime
    nvidia.prime = {
      # sudo lshw -c display
      sync.enable = false; # gpu on always lul

      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:10:0:0"; # "0a:00.0"
      # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
    };
  };

  # Load nvidia driver for Xorg and Wayland
  # https://nixos.org/manual/nixos/stable/options#opt-services.xserver.videoDrivers
  services.xserver.videoDrivers = [ "nvidia" ];
}
