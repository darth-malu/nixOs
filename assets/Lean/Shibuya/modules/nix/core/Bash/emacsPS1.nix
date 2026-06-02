''
  REDT="\[$(tput setaf 199)\]"
  GRON="\[$(tput setaf 43)\]"
  RESET="\[$(tput sgr0)\]"
  BOLD="\[$(tput bold)\]"
  # DIM="\[$(tput dim)\]"
  EXIT_COLOR=""

  # This function runs before each prompt
  exitstatus() {
    local stat="$?"
    if [[ $stat -ne 0 ]]; then
      EXIT_COLOR="$REDT" # Red for non-zero (failure)
    else
      EXIT_COLOR="$GRON" # Green for zero (success)
    fi
  }

  # EXIT_COLOR="\[\$(exitstatus)\]"

  PROMPT_COLOR=32 # green

  # PS1="\n$EXIT_COLOR$BOLD \w $RESET"
  PROMPT_COMMAND=exitstatus


  # Check if we're in a "dumb" terminal (no color support) or Emacs
  # if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
  if [ "$TERM" != "dumb" ]; then
    if [ -n "$INSIDE_EMACS" ]; then
      # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
      PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
    else
      PS1="\n$EXIT_COLOR$BOLD \w $RESET"
    fi

    # Set xterm window title (applies only to xterm-compatible terminals)
    # \033]2; sets the title, \007 is the bell character to terminate the sequence

    if test "$TERM" = "xterm"; then
      PS1="\[\033]2;\h:\u:\w\007\]$PS1"
    fi
  fi
  #\033 same as \e
  # u - user
  # h - host
  # w - cwd
  # \$ for normal # for root
''
