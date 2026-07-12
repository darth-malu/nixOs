''
  exitstatus() {
      local stat="$?"
      if [[ $stat -ne 0 ]]; then
          printf "%s" "$(tput setaf 199)"
      else
          printf "%s" "$(tput setaf 43)"
      fi
  }

  git_info() {
      local branch branch_icon icon
      branch_icon=$'\uE0A0'
      branch=$(git symbolic-ref --short HEAD 2>/dev/null) || \
          branch=$(git rev-parse --short HEAD 2>/dev/null) || return

      icon=$'\uF00C'
      [[ -n $(git status --porcelain 2>/dev/null) ]] && icon=$'\uF00D'

      printf '%s' "$(tput setaf 141)''${branch_icon}''${branch} ''${icon}$(tput sgr0)"
  }

  prompt_line1() {
      local gi display_pwd gi_len
      gi=$(git_info)
      display_pwd="''${PWD/#$HOME/~}"
      if [[ -n "$gi" ]]; then
          gi_len=$(printf '%s' "$gi" | sed $'s/\x1b\\[[0-9;]*m//g' | wc -m)
          printf '%s%*s' "$gi" "$((COLUMNS - gi_len - ''${#display_pwd}))" "$display_pwd"
      else
          printf '%*s' "$COLUMNS" "$display_pwd"
      fi
  }

  PS1='$(exitstatus=" $(exitstatus) "; echo "\[$exitstatus\]")'
  PS1+='\[$(tput bold)\]'
  PS1+='$(prompt_line1)'
  PS1+='\n• \[$(tput sgr0)\]'
''
