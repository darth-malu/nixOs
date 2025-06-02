{ pkgs, ... }:
{
  hardware = {
    graphics = {
      # hardware accel
      enable = true;
      #enable32Bit = true;
      # package = lib.mkIf config.programs.hyprland.enable inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers; # pkgs.mesa.drivers
      # package = pkgs.mesa.drivers;
      extraPackages = with pkgs; [
        # Additional packages to add to the default graphics driver lookup path. This can be used to add OpenCL drivers, VA-API/VDPAU drivers, etc.
        amdvlk
        #rocmPackages.clr.icd # opencl
      ];
    };
    amdgpu = {
      #initrd.enable = true; #  # early userspace, fix low res in boot scrn
      #opencl.enable = true; # Whether to enable OpenCL support using ROCM runtime library.
      amdvlk = {
        enable = true; # amd vulkan driver
        # package = pkgs.amdvlk;
        # supportExperimental.enable = true; #false::
      };
      opencl = {
        enable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ]; # pkgs providing systemd units and hooks
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
}
