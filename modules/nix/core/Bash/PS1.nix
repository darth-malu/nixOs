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

# PS1='$\[\$(exitstatus)\]\[$(tput bold)\]\[$(tput sc; printf "%*s" $COLUMNS "\[$(tput smul; printf "\w";tput sgr0;)\]"; tput rc)\]\n• \[$(tput sgr0)\]'
# Key Fix: Use a function call directly in PS1 or ensure proper escaping
# We wrap the dynamic function call in \[ \] to tell Bash it has zero width
PS1='$(exitstatus=" $(exitstatus) "; echo "\[$exitstatus\]")'
PS1+='\[$(tput bold)\]'
# Right-align the directory (\w) on the top line
PS1+='\[$(tput sc; printf "%*s" $COLUMNS "\[$(tput smul)\]\w\[$(tput sgr0)\]"; tput rc)\]'
# New line and the actual prompt bullet
PS1+='\n• \[$(tput sgr0)\]'
# BOLD="\[$(tput bold)\]"
# RESET="\[$(tput sgr0)\]"

# rightprompt() {
#     printf "%*s" $COLUMNS "$(date)"
# }

# PS1='$EXIT_COLOR\[$(tput bold)\]\[$(tput sc; printf "%*s" $COLUMNS \w; tput rc)\]\n+ \[$(tput sgr0)\]'

# PS1='$EXIT_COLOR\[$(tput bold)\]\[$(tput sc; printf "%*s" $COLUMNS \w; tput rc)\]\n+ \[$(tput sgr0)\]'

# PS1='$EXIT_COLOR\[$(tput bold)\]\[$(tput sc; printf "%*s" $COLUMNS "\[$(tput smul; printf "\w")\]"; tput rc)\]\n+ \[$(tput sgr0)\]'
# PS1="\n$EXIT_COLOR$BOLD\w\n• $RESET"
''
