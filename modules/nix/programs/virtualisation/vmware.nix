{ pkgs, ... }:

{

  virtualisation.vmware = {
    guest.enable = true;
    host = {
      enable = true;
      extraConfig = ''
        # Allow unsupported device's OpenGL and Vulkan acceleration for guest vGPU
        mks.gl.allowUnsupportedDrivers = "TRUE"
        mks.vk.allowUnsupportedDevices = "TRUE"'';
      extraPackages = with pkgs; [ ntfs3g ];
    };
  };
}
