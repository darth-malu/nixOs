{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true; # wine
      extraPackages = with pkgs; [
        # Additional packages to add to the default graphics driver lookup path. This can be used to add OpenCL drivers, VA-API/VDPAU drivers, etc.
        amdvlk
        rocmPackages.clr.icd # opencl
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    amdgpu = {
      #initrd.enable = true; #  # early userspace, fix low res in boot scrn
      overdrive.enable = true; # for lact
      opencl.enable = true; # Whether to enable OpenCL support using ROCM runtime library. # TODO see if need and where needed
      amdvlk = {
        enable = true; # amd vulkan driver
        # supportExperimental.enable = true; #false::
      };
    };

  };
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
    # LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
  };
  environment.systemPackages = with pkgs; [
    clinfo
    lact
  ]; # open cli verification
  # services.lact.enable = true;  # FIXME does not exist
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
}
