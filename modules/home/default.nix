{osConfig, ...}:

{
  imports = [
    ./pkgs+services-home.nix
    #./plasmaManager.nix
    ./tmux
    ./mpv
    ./zed-editor.nix
    ./xdg_mime.nix
    ./bash-home
    ./yt-dlp.nix
    ./git-home.nix
    #./sddm_theme.nix

    # folders
    ./scripts
    ./yazi
    ./kitty
    # ./nixvim
    # ./helix
    # core hyprland functionality
    ./soundStuff
    # ./homeSessionVariables.nix ./systemdUserSessionVariables.nix
    # ./specialisationHome.nix
  ] ++
  # (if osConfig.services.desktopManager.plasma6.enable != true then [ # WIP
  (if osConfig.programs.hyprland.enable then [ # WIP
    # mkMerge [
    #   ( mkIf config.wayland.windowManager.hyprland.enable {import} ) 
    # ]
    ./hyprland
    ./theming.nix
    # ./sync_thing.nix
  ] else []);
}
