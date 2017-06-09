# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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
    PATH="$HOME/bin:$PATH"
fi

# add go bin paths
PATH=$PATH:$GODIR/bin
PATH=$PATH:/usr/local/go/bin

# Add GOPATH
if [ -d $GODIR ] ; then
    export GOPATH=$GODIR
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

