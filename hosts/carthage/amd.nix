{
  hardware.graphics = {
    # previously hardware.opengl
    enable = true; # true:: Mesa + vulkan ->> /run/opengl-driver (for supported hardware)
    enable32Bit = true; # NOTE wine needs , vulkan 32 bit, vulkan on by default with radv
  };

  hardware.amdgpu = {
    #initrd.enable = true; #  # early userspace, fix low res in boot scrn
    overdrive.enable = true; # for lact
    opencl.enable = true; # OpenCL support using ROCM runtime library.(rocmPackages.clr + rocmPackages.clr.icd)
    amdvlk = {
      enable = true; # amd vulkan driver
      # support32Bit.enable = true;
      # package = pkgs.amdvlk;
      # supportExperimental.enable = true; # false::
    };
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
  };

  services.lact.enable = true;
}
