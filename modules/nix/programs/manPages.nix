{ pkgs, ... }:

{
  documentation.dev.enable = true;
  # This includes man pages targeted at developers if documentation.man.enable is set (this also includes "devman" outputs). true::
  # This includes info pages targeted at developers if documentation.info.enable is set (this also includes "devinfo" outputs). true::
  # This includes other pages targeted at developers if documentation.doc.enable is set (this also includes "devdoc" outputs). true::# distributed in pkgs /share/doc

  documentation.nixos = {
    includeAllModules = true; # false::
  };

  environment.systemPackages = with pkgs; [
    man-pages
  ];
}
