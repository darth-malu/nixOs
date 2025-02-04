{ pkgs, pkgs-unstable, config, lib, inputs, ...}:
{
  hardware = {
    graphics = {# hardware accel
        enable = true;
        #enable32Bit = true;
        # package = lib.mkIf config.programs.hyprland.enable inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers; # pkgs-unstable.mesa.drivers
        package = pkgs-unstable.mesa.drivers;
        extraPackages = with pkgs-unstable; [# add vulkan, vaapi/vdpau etc
          amdvlk 
        #rocmPackages.clr.icd # opencl
        ];
    };
    amdgpu = {
      #initrd.enable = true; #* # early userspace, fix low res in boot scrn
      #opencl.enable = true; # opecl support through ROCM runtime library #*
      amdvlk = {
        enable = true; # amd vulkan driver
        package = pkgs-unstable.amdvlk;
        # supportExperimental.enable = true; #false::
      };
      opencl = {
        enable = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ]; # pkgs providing systemd units and hooks
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
