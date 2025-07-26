{
  services.udev = {
    enable = true;
    extraRules = ''
      ACTION=="add",

    '';

  };
}
