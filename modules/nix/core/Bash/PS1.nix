''
exitstatus() {
	if [[ $? -ne 0 ]]; then
		printf "%s" "$(tput setaf 199)"
	else
		printf "%s" "$(tput setaf 43)"
	fi
}

git_info() {
	local branch icon
	branch=$(git symbolic-ref --short HEAD 2>/dev/null) ||
		branch=$(git rev-parse --short HEAD 2>/dev/null) || return
	# blank if not in git repo -- returns from function

	icon=$'\uF00C'
	[[ -n $(git status --porcelain 2>/dev/null) ]] && icon=$'\uF00D'

	printf '%s' "$(tput setaf 141)''${branch} ''${icon}$(tput sgr0)"
}

PS1='$(printf "\[%s\]" "$(exitstatus)")'
PS1+='\[$(tput bold)\]'
PS1+='\[$(tput sc; printf "%*s" $COLUMNS "\[\w\]"; tput rc)\]'
PS1+='$(git_info)'
PS1+='\n• \[$(tput sgr0)\]'
''
