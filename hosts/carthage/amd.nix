{ config, pkgs, ... }:
{
  hardware.graphics = {
    # previously hardware.opengl
    enable = true; # true:: MesaRADV + vulkan ->> /run/opengl-driver (for supported hardware)
    enable32Bit = true; # NOTE wine needs , vulkan 32 bit, vulkan on by default with radv
    extraPackages =
      with pkgs;
      (
        if config.networking.hostName == "tangier" then
          [
            intel-vaapi-driver
          ]
        else
          [
            # libvdpau
            # libvdpau-va-gl
          ]
      );
  };

  services.lact.enable = true; # need overdrive.enable

  hardware.amdgpu = {
    initrd.enable = true; # # early userspace, fix low res in boot scrn
    overdrive.enable = true; # sets amd.ppfeaturemask=0xffffffff; from default of 0x
    opencl.enable = true; # OpenCL ROCM runtime library.(rocmPackages.clr + rocmPackages.clr.icd)
  };

  nixpkgs.config.rocmSupport = true;

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
  };

  # Kernel params
  # boot.kernelParams = [
  # https://gist.github.com/danielrosehill/6a531b079906f160911a87dea50e1507
  # "amdgpu.gpu_recovery=1"
  # ];

}
