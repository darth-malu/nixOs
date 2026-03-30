{
  programs.rmpc = {
    enable = true; # Test more before deleting
    config = import ./rmpc-config.nix; # Config settings in Rusty Object Notation. $XDG_CONFIG_HOME/rmpc/config.ron
  };
}
