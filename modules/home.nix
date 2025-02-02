{
  imports = [
    #../../modules/home #old
    #../../modules/hyprland-carthageModules/home
    #../../modules/hyprland-carthageModules/home
    #../../../modules/hyprland-carthageModules/home
    #../../modules/home
    ../modules/home
    #./users-home.nix
  ];

  # options = {
  #   dunstHypr.homemanager.option = lib.mkOption {}
  # };
  # config = {
    home = {
      username = "malu";
      #groupname = "darth";
      homeDirectory = "/home/malu";
      stateVersion =  "24.05"; #TODO: make this different for the machines
      preferXdgDirectories = true;
    };
    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch"; #https://mynixos.com/home-manager/option/systemd.user.startServices # suggest, legacy, sd-switch
  # };

  # If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/malu/etc/profile.d/hm-session-vars.sh
  #
}
