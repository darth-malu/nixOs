{ pkgs-unstable, ... }:
{
  # previously hardware.opengl
  hardware.graphics = {
    enable = true; # vulkan #/run/opengl-driver
    enable32Bit = true; # wine needs , vulkan 32 bit, vulkan on by default with radv
    extraPackages = with pkgs-unstable; [
      # Additional packages to add to the default graphics driver lookup path. This can be used to add OpenCL drivers, VA-API/VDPAU drivers, etc.
      # amdvlk
      # rocmPackages.clr.icd # opencl
    ];
    extraPackages32 = with pkgs-unstable; [
      # driversi686Linux.amdvlk # TODO test if need
    ];
  };
  hardware.amdgpu = {
    #initrd.enable = true; #  # early userspace, fix low res in boot scrn
    overdrive.enable = true; # for lact
    opencl.enable = true; # Whether to enable OpenCL support using ROCM runtime library.
    amdvlk = {
      enable = true; # amd vulkan driver
      package = pkgs-unstable.amdvlk;
    };
    # amdvlk.supportExperimental.enable = true; # false::
  };

  # systemd.tmpfiles.rules = [
  # "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ]; # Most software has the HIP libraries hard-coded. You can work around it on NixOS by using:

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs-unstable.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs-unstable.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1"; # enable opencl polaris;
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib"; # TODO see if this needed
    # AMD_VULKAN_ICD = "RADV";
  };
  # services.lact.enable = true; # NOTE in unstable only
  environment.systemPackages = [ pkgs-unstable.lact ];
  systemd.packages = [ pkgs-unstable.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
}
