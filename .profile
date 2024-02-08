# .profile contains paths and variables set for user shell session

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

EDITOR="/usr/bin/nvim"
VISUAL=$EDITOR
GODIR="$HOME/src/go"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$HOME/.local/bin:$PATH"
fi

GODIR="$HOME/src/go"

# add go bin paths
PATH=$PATH:$GODIR/bin
PATH=$PATH:/usr/local/go/bin

# Add GOPATH
if [ -d $GODIR ] ; then
    export GOPATH=$GODIR
fi

# add nim paths
PATH=$PATH:/home/mitch/.nimble/bin

if [ -f /usr/bin/virtualenvwrapper.sh ] || [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/prog/python
    source /usr/bin/virtualenvwrapper.sh
fi
