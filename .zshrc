# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/mitch/.oh-my-zsh

# Path to zsh_custom dir
export ZSH_CUSTOM=$HOME/.zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="r00t"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pip python docker systemd tmux virtualenvwrapper)

source $ZSH/oh-my-zsh.sh

# User configuration
# Source aliases
if [ -f ~/.shell_aliases ]; then
    source $HOME/.shell_aliases
fi

# Source nvm 
export NVM_DIR="/home/mitch/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Source mkvirtualenv script add ~/.virtualenv directory containing virtualenv's
if [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/prog/python
    source /usr/local/bin/virtualenvwrapper.sh
fi
