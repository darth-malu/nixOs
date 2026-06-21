{ lib, pkgs, config, ...}:

{
  options.qemuNix = {
    enable = lib.mkEnableOption "homeHypr";
  };

  config = lib.mkIf config.qemuNix.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtiofsd
      virtio-win
    ];

    # virt manager
    virtualisation.libvirtd.enable = true;
    # if you use libvirtd on a desktop environment
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.groups.libvirtd.members = ["malu"];
    users.users.malu.extraGroups = [ "libvirtd" ];

    systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    };
}
