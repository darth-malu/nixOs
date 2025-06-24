{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Additional packages to add to the default graphics driver lookup path. This can be used to add OpenCL drivers, VA-API/VDPAU drivers, etc.
        amdvlk
        #rocmPackages.clr.icd # opencl
      ];
    };
    amdgpu = {
      #initrd.enable = true; #  # early userspace, fix low res in boot scrn
      # overdrive.enable = true;
      opencl.enable = true; # Whether to enable OpenCL support using ROCM runtime library. # TODO see if need and where needed
      amdvlk = {
        enable = true; # amd vulkan driver
        # supportExperimental.enable = true; #false::
      };
    };
  };
  # environment.systemPackages = with pkgs; [ lact ];
  # systemd.packages = with pkgs; [ lact ]; # pkgs providing systemd units and hooks
  # systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  # services.lact = {
  #   enable = true;
  # };
}
