{ osConfig, lib, ... }:

{
  imports = [
    # ./alias.nix
  ];
  programs.bash = {
    enable = true;
    sessionVariables = {
    };
    shellOptions = [
      # prefix with ~ to unset
      "histappend"
      # "checkwinsize" # on default
      "extglob" # extended globbing
      "nullglob" # incase empty...return empty not literal str with **
      "globstar"
      "checkjobs"
      "cmdhist" # save multi-line cmd into one line
    ];
    historyFileSize = 10000000; # 100,000:: - on file
    shellAliases = import ./alias.nix;
    historySize = 10000; # 10,000:: - in memory
    historyControl = [
      "ignoreboth" # ignore duplicate commands, ignore commands starting with a space
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
      "l"
      "which"
      "yy"
      "fd"
      ":(){  :|:& };:"
      "pass"
      "yt"
      "shutdown"
      "gemini"
      "opencode"
    ];
    profileExtra =
      lib.mkIf (osConfig.kde.enable == false)
        #loginshell
        ''
           if uwsm check may-start; then
             start-hyprland
          fi
        '';
    # extra commands interactive shell/ also in non interactive
    # bashrcExtra = '''';
    initExtra =
      # during interactive shell init
      ''
        nixify() {
          if [ ! -e ./.envrc ]; then
            echo "use nix" > .envrc
            direnv allow
          fi
          if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
            cat > default.nix <<'EOF'
        with import <nixpkgs> {};
        mkShell {
          nativeBuildInputs = [
            bashInteractive
          ];
        }
        EOF
            ''${EDITOR:-vim} default.nix
          fi
        }
        flakify() {
          if [ ! -e flake.nix ]; then
            nix flake new -t github:nix-community/nix-direnv .
          elif [ ! -e .envrc ]; then
            echo "use flake" > .envrc
            direnv allow
          fi
          ''${EDITOR:-vim} flake.nix
        }

        #complete command + file names. Investigate if needed
        #complete -cf sudo

        # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin" # should be below in bashrcExtra
        if command -v fzf-share >/dev/null; then
          source "$(fzf-share)/key-bindings.bash"
          source "$(fzf-share)/completion.bash"
        fi
      '';
  };
}
