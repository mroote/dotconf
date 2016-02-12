alias tmux='tmux -2'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#  Add config command for local conf files.  
#  This Alias allows adding and editing config files for each computer
#  Each computer can get a new branch
#  
#  To Create:
#    git init --bare $HOME/.myconf
#    config config status.showUntrackedFiles no
#  Ex:
#    config status
#    config add .vimrc
#    config commit -m "Add vimrc"
#    config add .config/redshift.conf
#    config commit -m "Add redshift config"
#    config push
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
