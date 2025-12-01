''
  exitstatus() {
      local stat="$?"
      if [[ $stat -ne 0 ]]; then
          printf "%s" "$(tput setaf 199)" # 161
      else
          printf "%s" "$(tput setaf 43)" # 43
      fi
  }

  EXIT_COLOR="\[\$(exitstatus)\]"
  BOLD="\[$(tput bold)\]"
  RESET="\[$(tput sgr0)\]"

  # PROMPT_COMMAND=""             # Try as fix for emacs shell issue

  PS1="\n$EXIT_COLOR$BOLD \w $RESET"
''
