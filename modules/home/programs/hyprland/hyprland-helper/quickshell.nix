{
  inputs,
  pkgs,
  ...
}:
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default; # OR use stable
    # activeConfig = "$HOME/Shibuya/modules/home/programs/hyprland/hyprland-helper/quickshell"; # if null use $XDG_CONFIG_HOME/quickshell::
    systemd = {
      enable = true;
      # target = "hyprland-session.target"; # config.wayland.systemd.target:: (graphical-session-target) # HACK:, hyprland-session.target
      target = "graphical-session.target";
    };
  };

  # Quickshell stuffs https://quickshell.org/docs/v0.2.0/guide/install-setup/
  home.packages =
    with pkgs.kdePackages;
    [
      kirigami
      kirigami-addons
      kirigami-gallery
      qt5compat
    ]
    ++ (with pkgs; [
      qt6.qtimageformats # webp & less common format support
      # qt6.qt5compat # extra visual effects, notably gaussian blur. MultiEffect is usually preferable
      # qt6.qtsvg # support for SVG image loading (bundled with most packages) # NOTE its still fetched?
      qt6.qtmultimedia # support for playing videos, audio, etc
      qt6.qtdeclarative # qtdecl types in path
    ]);
}
