if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

set -x GPG_TTY (tty)
set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"

set -xg EDITOR vim

set -xg DESK ~/Desktop

set -xg configfish '~/.config/fish/config.fish'
alias confish="$EDITOR $configfish && refreshfish && echo sourced $configfish"
alias refreshfish="source $configfish"

set -g fish_prompt_pwd_dir_length 3
set fish_greeting ''
function fish_prompt
	set_color green
	echo \@(prompt_pwd)\>(set_color normal)
end

alias py="python"
alias cls="clear"
alias csl=cls
alias sysu="systemctl --user"
alias sl="cd ~/p/suckless"
alias prog="cd ~/p"
function download
	curl --remote-name $argv
end

#alias "git stat" = "git status"



alias suspend="systemctl suspend"
