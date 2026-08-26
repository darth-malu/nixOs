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

	# git diff --quiet HEAD is O(changed files) not O(entire tree) like git status --porcelain
	# This makes it fast even in large repos (linux kernel, monorepos, etc.)
	if git diff --quiet HEAD 2>/dev/null; then
		icon=$'\uF00C'
	else
		icon=$'\uF00D'
	fi

	printf '%s' "$(tput setaf 141)''${branch} ''${icon}$(tput sgr0)"
}

ssh_info() {
	[[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" ]] &&
		printf '%s' " $(tput setaf 214)\uf023$(tput sgr0)"
}

PS1='$(printf "\[%s\]" "$(exitstatus)")'
PS1+='\[$(tput bold)\]'
PS1+='\[$(tput sc; printf "%*s" $COLUMNS "\[\w\]"; tput rc)\]'
PS1+='$(git_info)'
PS1+='$(ssh_info)'
PS1+='\n• \[$(tput sgr0)\]'
''
