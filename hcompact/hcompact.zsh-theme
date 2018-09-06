function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg_bold[red]%}%_#"; else echo "%{$fg_bold[green]%}%_$"; fi
}

function operating_system {

    OPS=$(uname)

    if [[ $OPS == "Linux" ]]; then
         CAT=$(grep "NAME" < /etc/os-release | cut -d '=' -f 2 | head -n 1 | cut -d '"' -f 2)

         if [[ $CAT == "Gentoo" ]]; then
              printf "Gentoo Linux"
         elif [[ $CAT == "CentOS Linux" ]]; then
              printf "CentOS"
         elif [[ $CAT == "void" ]]; then
              printf "Void"
         else
              # $CAT is right for Fedora and Linux Mint, at least
              printf "$CAT"
         fi
    else

         printf "$OPS"

    fi
}

function kernel {

    KERNEL=$(uname -r)

    printf "Kernel: $KERNEL"

}

function user {
	if [[ $USER == "root" ]]; then
		printf '\e[1;31m%-6s\e[m' "root"
	else
		printf '\e[1;32m%-6s\e[m' "${USER}"
	fi
}

export OPS=$(operating_system)

if [[ ${OPS} == "openSUSE"* ]] || [[ ${OPS} == "Linux Mint" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[green]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ ${OPS} == "CentOS" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[cyan]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ ${OPS} == "FreeBSD" ]] || [[ ${OPS} == "Scientific Linux" ]] || [[ ${OPS} == "Ubuntu" ]] ; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[red]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ ${OPS} == "Arch Linux" ]] || [[ ${OPS} == "Fedora" ]] || [[ ${OPS} == "Mageia" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[blue]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ ${OPS} == "Gentoo Linux" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[purple]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ ${OPS} == "Void" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[white]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
elif [[ $(uname) == "Linux" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$fg_bold[yellow]${OPS}] $(user) %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
