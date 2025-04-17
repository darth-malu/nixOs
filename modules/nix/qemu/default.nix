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

    systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    };
}
