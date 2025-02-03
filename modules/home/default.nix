{osConfig, ...}:

{
  imports = [
    # ./home-pkgs.nix
    ./pkgs_home.nix
    #./plasmaManager.nix
    ./tmux
    ./mpv
    ./zed-editor.nix
    ./xdg_mime.nix
    ./bash
    ./yt-dlp.nix
    ./git-home.nix
    #./sddm_theme.nix

    # folders
    ./scripts
    ./yazi
    ./kitty
    ./textEditor
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
    ./themes.nix
    # ./sync_thing.nix
  ] else []);
}
