let
  fromSecond = "\${@:2}";
  fromThird = "\${@:3}";
in
{
  imports = [
    # ./alias.nix
  ];
  programs.bash = {
    enable = true;
    sessionVariables = {
     # ignore duplicate commands, ignore commands starting with a space
     #HISTCONTROL="ignoreboth:erasedups"; #ignoreboth=space+ingoredups , : - delimeter
    };
    historyFileSize = 100000;
    shellAliases = import ./alias.nix;
    historySize = 10000;
    historyControl = ["ignoreboth" "erasedups"];
    historyIgnore = [ "ls" "rg" "bemoji" "lss" "lxx" "cd" "exit" ];
    profileExtra =
    #loginshell
    /*bash*/
    ''
        if uwsm check may-start; then
          exec uwsm start -S hyprland-uwsm.desktop
       fi
    '';
    # extra commands interactive shell/ also in non interactive
    # bashrcExtra = '''';
    initExtra =
      # during interactive shell init
    /*bash*/''


    #complete command + file names. Investigate if needed
    #complete -cf sudo

    math ()
    {
    echo "scale=2;$1" | bc
    }

    # task
    t ()
    {
      case $1 in
        "-a")
            task add project:arch "${fromSecond}"
            ;;
        "-n")
            task add project:nix  "${fromSecond}"
            ;;
        "-m")
            task add project:movies  "${fromSecond}"
            ;;
        "-nv")
            task add project:nixvim  "${fromSecond}"
            ;;
        "-t")
            task add project:teal "${fromSecond}"
            ;;
        "-p")
            task project:"$2" add "${fromThird}"
            ;;
        "-N")
            task project:nixvim add "${fromSecond}"
            ;;
        "-l")
            task list
            ;;
        "-lp")
            task list project:"$2"
            ;;
        "-d")
            task delete "${fromSecond}"
            ;;
        "-ln"|"-nl")
            task list project:nix
            ;;
        "-lm"|"-ml")
            task list project:movies
            ;;
        "-lnv")
            task list project:nixvim
            ;;
        "-la"|"-al")
            task list project:arch
            ;;
        *)
            task add "$1"
            ;;
      esac
    }

    # systemctl qol
    sys () {
      case $1 in
        "user")
          case $2 in
            "start")
              systemctl --user start $3
              ;;
            "stop")
              systemctl --user stop $3
                ;;
            "status")
                systemctl --user status $3
                ;;
            "enable")
                systemctl --user enable $3
                ;;
            "restart")
                systemctl --user restart $3
                ;;
            "daemon")
                systemctl --user daemon-reload
                ;;
          esac
          ;; ###### end of user
        "start")
            systemctl start $2
            ;;
        "stop")
            systemctl stop $2
            ;;
        "status")
            systemctl status $2
            ;;
        "restart")
            systemctl restart $2
            ;;
        "enable")
            systemctl enable $2
            ;;
        "disable")
            systemctl disable $2
            ;;
        "daemon")
            systemctl daemon-reload
            ;;
        *)
            echo "Sys function failed...check bash config"
            ;;
      esac
    }

    # yazi
    function yy() {
      local yazi_tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$yazi_tmp"
      if cwd="$(cat -- "$yazi_tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$DIM_BOLD_PWD" ]; then
          builtin cd -- "$cwd"
      fi
      rm -f -- "$yazi_tmp"
    }

    # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin" # should be below in bashrcExtra
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi
    '';
    shellOptions = [ #prefix with ~ to unset
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"
    ];
  };
}
