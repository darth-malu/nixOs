{ 
  programs.bash = {
    completion.enable = true;
    promptInit = import ./PS1.nix;
    enableLsColors = true;
    #blesh.enable = true;
    undistractMe = { #ISSUES
     enable = false;
      timeout = 30; #seconds
      playSound = false;#TODO: can this be improved??
    };
    # shell init
    # loginShellInit = /*bash*/ ''
    #   if uwsm check may-start; then
    #     # exec uwsm start -s hyprland-uwsm.desktop
    #     exec uwsm start hyprland-uwsm.desktop
    #     # exec uwsm start -S hyprland.desktop
    #     # exec uwsm start hyprland-systemd.desktop
    #   fi
    # '';
    # shellInit = /*bash*/ ''
    #   if uwsm check may-start && uwsm select; then
    #     exec systemd-cat -t uwsm_start uwsm start default
    #   fi
    # '';
    # interactiveShellInit = /*bash*/ ''
    # '';
  };

}

