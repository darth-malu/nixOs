{osConfig, ...}:

{
  imports = [
    ./home-pkgs.nix
    #./plasmaManager.nix
    ./tmux
    ./mpv
    ./xdg_mime.nix
    ./bash
    ./yt-dlp.nix
    ./git-home.nix
    #./sddm_theme.nix

    ./scripts
    ./yazi
    ./kitty
    ./wezterm
    ./textEditor
    # ./nixvim
    # ./helix
    ./soundStuff
    # ./homeSessionVariables.nix ./systemdUserSessionVariables.nix
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
