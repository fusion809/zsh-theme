function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg_bold[red]%}%_#"; else echo "%{$fg_bold[green]%}%_$"; fi
}

function operating_system {

    OS=$(uname)

    if [[ $OS == "Linux" ]]; then
         CAT=$(cat /etc/os-release | grep "NAME" | cut -d '=' -f 2 | head -n 1 | cut -d '"' -f 2)

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

         printf "$OS"

    fi
}

function kernel {

    KERNEL=$(uname -r)

    printf "Kernel: $KERNEL"

}

if [[ $USER == "root" ]]; then
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$(operating_system)$fg_bold[yellow]] %{$fg_bold[red]%}%n%{$fg_bold[cyan]%} %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
else
	PROMPT='$fg_bold[yellow][%D{%H:%M:%S}|$(operating_system)$fg_bold[yellow]] %{$fg_bold[green]%}%n%{$fg_bold[cyan]%} %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)
% $(prompt_char)%{$reset_color%} '
fi

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
