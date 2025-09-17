{ config, pkgs, ... }:
{
  hardware.graphics = {
    # previously hardware.opengl
    enable = true; # true:: Mesa + vulkan ->> /run/opengl-driver (for supported hardware)
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

  services.lact.enable = true;

  hardware.amdgpu = {
    #initrd.enable = true; #  # early userspace, fix low res in boot scrn
    overdrive.enable = true; # required -> lact
    opencl.enable = true; # OpenCL ROCM runtime library.(rocmPackages.clr + rocmPackages.clr.icd)
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
  };
}
