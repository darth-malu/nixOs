{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:

# let
# inherit (inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}) mesa;
# myMesa = (inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}) mesa.drivers;
# in
{
  options.niri = {
    enable = lib.mkEnableOption "Niri trial";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
    };
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "myuser";
        };
      };
    };
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = {};

    programs.waybar.enable = true; # top bar
    environment.systemPackages = with pkgs; [ alacritty fuzzel swaylock mako swayidle ];
  };
}
