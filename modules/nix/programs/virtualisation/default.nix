{ pkgs, ... }:
{
  imports = [
    ./qemu
    ./n8n.nix
    ./docker.nix
  ];

  qemu.enable = true;
  docker.enable = true;
  n8n.enable = false;

  virtualisation = {
    vmware = {
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
    waydroid.enable = false;
    virtualbox = {
      guest.enable = false;
      host = {
        enable = false;
        enableExtensionPack = false; # usb2/3 forward to guests #NOTE: frequent recompilation with host extensions
        # enableKvm = true; # better compat with linux kernel versions
        # addNetworkInterface = true; # true:: -vboxnet0
      };
    };
  };

  # For VBOX
  users.extraGroups.vboxusers.members = [ "malu" ];

  environment.systemPackages = [
    pkgs.genymotion
    pkgs.moonlight-qt
  ];
}
