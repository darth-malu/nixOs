{
  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_UUID}=="1406242A06240F74", RUN{program}+="/home/malu/.nix-profile/bin/systemd-mount --no-block --automount=yes --collect /dev/%k /home/malu/udevStorage/SumbiHDD"
    '';
  };
}
