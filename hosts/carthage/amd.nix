{
  # previously hardware.opengl
  hardware.graphics = {
    enable = true; # vulkan #/run/opengl-driver
    enable32Bit = true; # wine needs , vulkan 32 bit, vulkan on by default with radv
  };
  hardware.amdgpu = {
    #initrd.enable = true; #  # early userspace, fix low res in boot scrn
    overdrive.enable = true; # for lact
    opencl.enable = true; # OpenCL support using ROCM runtime library.(rocmPackages.clr + rocmPackages.clr.icd)
    amdvlk = {
      enable = true; # amd vulkan driver
      support32Bit.enable = true;
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
