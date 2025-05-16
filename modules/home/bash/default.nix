{ osConfig, pkgs, ... }:

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
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
    historyIgnore = [
      "ls"
      "rg"
      "bemoji"
      "yazi"
      "lss"
      "lxx"
      "cd"
      "exit"
    ];
    profileExtra =
      # if (osConfig.kde.enable == false) then # INFO: only launch when hyrpland option is enabled
      if (osConfig.kde.enable == false) then
        #loginshell
        # bash
        ''
           if uwsm check may-start; then
             exec uwsm start -S hyprland-uwsm.desktop
          fi
        ''
      else
        '''';
    # extra commands interactive shell/ also in non interactive
    # bashrcExtra = '''';
    initExtra =
      # during interactive shell init
      ''
        yT() {
          case $1 in
            "a")
              yt-dlp -P "$HOME/Music/ytDlp-audio/" --extract-audio --audio-format mp3 "''${@:2}"
              ;;
            "v")
              yt-dlp -P "$HOME/Music/musicVideos/" "''${@:2}"
              ;;
            "k")
              yt-dlp -P "$HOME/Videos/YtDlp/keniaWOKE/" "''${@:2}"
              ;;
             *)
              printf '%s\n' "Invalid option. Usage: yT a| v|k 'url1' 'url2' ..."
              ;;
            esac
        }
        #complete command + file names. Investigate if needed
        #complete -cf sudo

        # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin" # should be below in bashrcExtra
        if command -v fzf-share >/dev/null; then
          source "$(fzf-share)/key-bindings.bash"
          source "$(fzf-share)/completion.bash"
        fi
      '';
    shellOptions = [
      # prefix with ~ to unset
      "histappend"
      "checkwinsize"
      "extglob" # extended globbing
      "globstar"
      "checkjobs"
    ];
  };
}
