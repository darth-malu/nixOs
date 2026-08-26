{ lib, osConfig, ... }:
{
  programs.bash.enable = true;
  programs.bash.shellOptions = [
    # prefix with ~ to unset
    "histappend"
    # "checkwinsize" # on default
    "extglob" # extended globbing
    "nullglob" # incase empty...return empty not literal str with **
    "globstar"
    "checkjobs"
    "cmdhist" # save multi-line cmd into one line
  ];
  programs.bash.historyFileSize = 10000000;
  programs.bash.shellAliases = import ./alias.nix;
  programs.bash.historySize = 10000;
  programs.bash.historyControl = [
    "ignoreboth" # ignore duplicate commands, ignore commands starting with a space
    "erasedups"
  ];
  programs.bash.historyIgnore = [
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

  # initExtra -> interactive shell counterpart
  # programs.bash.profileExtra = # init Login shell
  #   '' '';

  programs.bash.bashrcExtra = # extra cmd for bashrc
    ''
      # SUDO_PROMPT: reset + red (color 199) + lock icon + reset
      export SUDO_PROMPT=$'\033[0m\033[38;5;199m \uf023 \033[0m '

      rM() {
        trash-put "$@"; echo "🧻 $@ "
      }

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
        vim flake.nix
      }

      #complete command + file names.
      #complete -cf sudo

      # \eh to pull help like in ZSHELL
      run-help() { help "$READLINE_LINE" 2>/dev/null || batman "$READLINE_LINE"; }
      bind -m vi-insert -x '"\eh": run-help'
      bind -m vi-insert -x '"\el": lsd;printf "\n"'
      # bind -m emacs -x     '"\eh": run-help'

      # Macros
      # bind '"\ew": "\C-e # macro"'
    '';

  programs.bash.initExtra = # cmd for when init Interactive shell
    ''
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
    '';
}
