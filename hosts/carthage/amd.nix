{ pkgs, pkgs-unstable, ... }:

{
  # previously hardware.opengl
  hardware.graphics = {
    enable = true; # vulkan #/run/opengl-driver
    # enable32Bit = true; # wine needs , vulkan 32 bit, vulkan on by default with radv
    # extraPackages = with pkgs; [
    # Additional packages to add to the default graphics driver lookup path. This can be used to add OpenCL drivers, VA-API/VDPAU drivers, etc.
    # amdvlk
    # rocmPackages.clr.icd # opencl
    # rocmPackages.clr
    # mesa.opencl
    # ];
    # extraPackages32 = with pkgs; [
    # driversi686Linux.amdvlk # TODO test if need
    # ];
  };
  hardware.amdgpu = {
    #initrd.enable = true; #  # early userspace, fix low res in boot scrn
    overdrive.enable = true; # for lact
    opencl.enable = true; # Whether to enable OpenCL support using ROCM runtime library.
    amdvlk = {
      enable = true; # amd vulkan driver
      # package = pkgs.amdvlk;
      supportExperimental.enable = true; # false::
    };
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
    # When a program is installed in your environment, these libraries should be found automatically. However, this is not the case in a `nix-shell`. use LD_L*
    # LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    # AMD_VULKAN_ICD = "RADV"; # AMDVLK ::, RADV
    # VDPAU_DRIVER = "radeonsi"; # NOTE try as fix for openCl issues
  };
  services.lact.enable = true;
}
