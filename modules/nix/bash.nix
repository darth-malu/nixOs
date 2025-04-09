{
  bash.completion.enable = true;
  bash.promptInit = import ./PS1.nix;
  bash.enableLsColors = true;
  #blesh.enable = true;
  bash.undistractMe = {
    # ISSUES
    enable = true;
    timeout = 30; # seconds
    playSound = true; # TODO: can this be improved??
  };
  # bash.loginShellInit = /*bash*/ ''
  # '';
  # bash.shellInit = /*bash*/ ''
  # '';
  # bash.interactiveShellInit = ''
  # '';
}
