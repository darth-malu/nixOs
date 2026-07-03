{ config, pkgs, ... }:
{
  hardware.graphics = {
    # previously hardware.opengl
    enable = true; # true:: MesaRADV + vulkan ->> /run/opengl-driver (for supported hardware)
    enable32Bit = true; # NOTE wine needs , vulkan 32 bit, vulkan on by default with radv
    extraPackages = [
      # libvdpau
      # libvdpau-va-gl
    ];
  };

  services.lact.enable = pkgs.lib.mkIf config.hardware.amdgpu.overdrive.enable true; # need overdrive.enable

  hardware.amdgpu = {
    initrd.enable = true; # # early userspace, fix low res in boot scrn
    overdrive.enable = true; # sets amd.ppfeaturemask=0xffffffff; from default of 0x
    opencl.enable = true; # OpenCL ROCM runtime library.(rocmPackages.clr + rocmPackages.clr.icd)
  };

  nixpkgs.config.rocmSupport = true;
  /*
    Whether or not a package is built with ROCm support is controlled by the rocmSupport nixpkgs config variable. As HIP is a component of ROCm, anything that needs HIP support (e.g. Blender) gets that enabled through rocmSupport too.
      You can set it globally with this line
  */
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
  };

  # Kernel params
  # boot.kernelParams = [
  # https://gist.github.com/danielrosehill/6a531b079906f160911a87dea50e1507
  # "amdgpu.gpu_recovery=1"
  # ];

}
