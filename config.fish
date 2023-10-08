if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        startx /usr/bin/startxfce4
    end
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 2
        startx /usr/bin/i3
    end

	#xsetwacom --list devices
	#todo sed "pad" -> number
	#xsetwacom set 12 MapToOutput 2304x1440+1920+0
		
	#firefox & disown
	#brave & disown
	#discord & disown
end

fish_add_path -a /opt/cuda/bin /opt/cuda/nsight_systems/bin

set -x GPG_TTY (tty)
set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

alias vim="nvim"
alias vimrc="vim ~/.vimrc"
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

alias sus="systemctl suspend"
alias edit="subl -n "
alias py="python"
alias cls="clear"
alias csl=cls
alias m="make"
alias sysu="systemctl --user"
alias mclp="make 2>&1 | clip"
alias mles="make 2>&1 | less"
alias ble="blender --python-use-system-env"
alias windo="sudo efibootmgr --bootnext 0001 && reboot"
alias ema="emacs -nw"
alias servehere="py -m http.server"
alias zb="zig build"
alias zr="zig run"

#notes
function todo
	echo $argv >> todo.txt
end
function rant
	echo $argv >> rants.txt
end

function clip
	xclip -selection clipboard
end

function search
	tree -f | grep -i "$argv"
end


#directories
alias sl="cd ~/p/suckless"
alias prog="cd ~/p"
alias p3="cd ~/p/3"
alias less="less -R"

#dev envs
alias alk="cd ~/p/alkahest & thunar & /opt/sublime_text/sublime_text"

#git
alias gstat="git status"
alias gadd="git add ."
alias gam="git commit --amend"
alias gdiff="git diff HEAD~1 --stat"
function gommit
	git add .
	git commit -m "$argv"
end
function clone
	git clone $argv
end
function cloneshallow
	git clone $argv --depth 1 --recurse-submodules --shallow-submodules
end

#downloading
function mvd
	mv $argv[1] -t $argv[2]
end
function dl
	curl --remote-name $argv
end
function pacdl
	sudo pacman -S $argv
end

function upgrade
	sudo pacman -Sy archlinux-keyring && sudo pacman -Su && sudo /root/fixbootlol.sh
end

function dn
	$argv & disown
end 

#ffmpeg
function ffpngi
	ffmpeg -framerate $argv[1] -i %4d.png -b:v 8M -c:v libx264 -crf 6 -pix_fmt yuv420p -preset slow -c:a aac -movflags +faststart $argv[2]
end
function ffloop
	ffmpeg -stream_loop $argv[1] -i $argv[2] -c copy $argv[3]
end
function ffcat
	ffmpeg -f concat -safe 0 -i <(echo "file '$argv[1]'" echo "file '$argv[2]'";) -c copy $argv[3]
end
function ffclip
	ffmpeg -i $argv[1] -ss $argv[2] -t $argv[3] -c copy $argv[4]
end

# opam configuration
source /home/khlor/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
