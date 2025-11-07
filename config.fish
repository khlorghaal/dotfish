if status is-login
    if test -z "$DISPLAY"
 	if test "$XDG_VTNR" = 1
		startx /usr/bin/startxfce4
		xsetwacom set $(xsetwacom --list devices | awk '/pad/{print $NF}' | cut -d: -f2) MapToOutput 2304x1440+0+0
	end
	if test "$XDG_VTNR" = 2
		startx /usr/bin/i3
		/.config/i3_xrandr.sh
	end
end
end

#capital space
xmodmap -e "keycode 65 = space underscore space underscore"

fish_add_path -a /opt/cuda/bin /opt/cuda/nsight_systems/bin

set -x GPG_TTY (tty)
set -e SSH_AGENT_PID
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

alias vim="nvim"
alias vimrc="nvim ~/.vimrc"

alias subl="/opt/sublime_text/sublime_text"
set -xg EDITOR nvim


set -xg DESK ~/Desktop

set -xg configfish ~/.config/fish/config.fish
function confish
	$EDITOR $configfish
	source $configfish
end


set -g fish_prompt_pwd_dir_length 3
set fish_greeting ''
function fish_prompt
	set_color green
	echo \@(prompt_pwd)\>(set_color normal)
end

alias less="less -r"

alias cdd="cd .."
alias cddd="cd ../.."

alias vim="nvim"
alias sus="systemctl suspend"
alias edit="subl -n "
alias py="python"
alias cls="clear"
alias csl=cls
alias sysu="systemctl --user"
alias m="make"
alias mc="make &| clip"
alias ml="make &| less"
alias me="make &| grep 'error' | less"
alias ble="blender --python-use-system-env"
alias windo="sudo efibootmgr --bootnext 0001 && reboot"
alias em="emacs -nw"
alias shud="shutdown now"
alias servehere="py -m http.server"
alias renet="sudo systemctl restart NetworkManager"
alias chx="chmod +x"
alias kill="killall -s 9"
alias venv="source venv/bin/activate.fish"

#notes
function todo
	echo $argv >> ~/docs/todo.txt
end
function rant
	echo $argv >> ~/docs/rants.txt
end

function clip
	xclip -selection clipboard
end

function search
	tree -f | grep -i "$argv"
end
function replace
	find . -type f -exec sed -i "s/$argv[1]/$argv[2]/g" {} +
end

#directories
alias sl="cd ~/p/suckless"
alias p3="cd ~/p/3"

function tail
	/bin/tail -F $argv[1] 2>&1 | sed -u 's/^tail: .*: file truncated/\x1b[2J/'
end


#dev envs
function dev
	cd ~/p/$argv[1] & subl .
	tmux kill-session -t ide
	tmux new-session -d -s ide
	tmux select-layout -t ide tiled
	tmux split-window -h
	tmux split-window -v
	tmux send-keys -t ide:0.1 "clear && tail ./stdout" Enter
	tmux send-keys -t ide:0.2 "clear && tail ./stderr" Enter
	tmux attach-session -t ide
end

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
	git clone $argv --depth 1 --recurse-submodules --shallow-submodules --single-branch
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

function syu
	sudo pacman -Sy archlinux-keyring && sudo pacman -Su
end

function dn
	$argv & disown
end 

#ffmpeg
function ffspeed
	ffmpeg -i $argv[1] -filter:a "rubberband=tempo=$argv[2]" -filter:v "setpts=$argv[3]*PTS" $argv[4]
end
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
	ffmpeg -i $argv[1] -ss $argv[2] -t $argv[3] $argv[4]
end

function udisc
	sudo mv /home/khlor/Downloads/discord* -t /opt/discord
	sudo tar -zxvf /opt/discord/discord-*.tar.gz -C /opt/discord
	sudo rm /opt/discord/discord-*.tar.gz
end

