/*bash*/
''
exitstatus() {
 local stat="$?"
  if [[ $stat -ne 0 ]]; then
    printf "%s" "$(tput setaf 199)" # 161
  else
    printf "%s" "$(tput setaf 43)" # 43 
  fi
}

# EXIT_COLOR="$(exitstatus)"
EXIT_COLOR="\[\$(exitstatus)\]"
# BOLD="\[$(tput bold)\]"
# RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"
DIM="\[$(tput dim)\]"
RESET="\[$(tput sgr0)\]"

PS1="\n$EXIT_COLOR$BOLD \w $RESET"
''
