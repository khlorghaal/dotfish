if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

set -x EDITOR vim

set -x configfish '~/.config/fish/config.fish'
alias refreshfish="source $configfish"
alias confish="$EDITOR $configfish && refreshfish && echo sourced $configfish"

alias py="python"
alias cls="clear"
alias csl=cls
