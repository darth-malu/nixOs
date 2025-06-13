{ lib, pkgs, config, ...}:

{
  options.qemuNix = {
    enable = lib.mkEnableOption "homeHypr";
  };

  config = lib.mkIf config.qemuNix.enable {
    environment.systemPackages = [
      pkgs.qemu
    ];

    # virt manager
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    users.groups.libvirtd.members = ["malu"];
  # users.users.<myuser>.extraGroups = [ "libvirtd" ];

    systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    };
}
