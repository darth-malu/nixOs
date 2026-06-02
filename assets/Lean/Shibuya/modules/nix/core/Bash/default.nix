{
  programs.bash = {
    completion.enable = true;
    promptInit = import ./PS1.nix;
    enableLsColors = true;
    #blesh.enable = true;
    undistractMe = {
      enable = false;
      timeout = 30; # seconds
      playSound = true;
    };
    # bash.loginShellInit = /*bash*/ ''
    # '';
    # bash.shellInit = /*bash*/ ''
    # '';
    # bash.interactiveShellInit = ''
    # '';
  };
}
