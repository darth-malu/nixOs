{
  osConfig,
  config,
  lib,
  ...
}:
{
  /*
    If you need to reference another session variable (even if it is declared by using other options like ), then do so inside Nix instead. The above example then becomes
    A default value foo may be given as per ${parameter:-foo} and, similarly, an alternate value bar can be given as per ${parameter:+bar}.

    home.sessionVariables = {
      FOO = "Hello";
      BAR = "${config.home.sessionVariables.FOO} World!";
    };
  */

  programs.bash.profileExtra = ''
     if uwsm check may-start; then
       start-hyprland
    fi
  '';

  home.sessionVariables = {
    # Broken
  };

  home.sessionPath = [
    # Prepend to $PATH in a double-quoted context
    "${config.home.homeDirectory}/.cache/.bun/bin"
    "${config.home.homeDirectory}/.bun/bin"
    "/home/malu/.bun/bin"
  ];

  xdg.configFile = {
    "uwsm/env" = {
      enable = lib.mkIf osConfig.programs.hyprland.withUWSM true;
      source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    };
    "mimeapps.list".force = true;
  };
}
