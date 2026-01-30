{ config, ... }:
{
  programs.direnv = {
    nix-direnv = {
      enable = true;
    };
    enable = true;
    # direnvrcExtra = ''
    #   export FOO="foo"
    #   echo "loaded darth-direnv"
    # ''; # NOTE only in nix direnv
    enableBashIntegration = config.programs.bash.enable;
    # loadInNixShell = true; # true::
    # silent = false;
    config = {
      # TOML value -> $XDG_CONFIG_HOME/direnv/direnv.toml
      global = {
        log_format = "-";
        log_filter = "^$";
      };
    };
  };
}
