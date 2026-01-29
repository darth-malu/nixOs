{
  programs.direnv = {
    nix-direnv = {
      # enable = true;
    };
    enable = true;
    direnvrcExtra = ''
      export FOO="foo"
      echo "loaded darth-direnv"
    '';
    enableBashIntegration = true;
    # loadInNixShell = true; # true::
    # silent = false;
    settings = {
      # TOML value -> direnv.toml
      global = {
        log_format = "-";
        log_filter = "^$";
      };
    };
  };
}
