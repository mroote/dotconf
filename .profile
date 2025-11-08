# .profile contains paths and variables set for user shell session

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

EDITOR="/usr/bin/nvim"
VISUAL=$EDITOR
GODIR="$HOME/src/go"
ASDFDIR="$HOME/.asdf"

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

if [ -d "$HOME/.nimble" ] ; then
    # add nim paths
    PATH=$PATH:/home/mitch/.nimble/bin
fi

if [ -d "$HOME/.yarn" ] ; then
    # add yarn paths
    PATH=$PATH:/home/mitch/.yarn/bin
fi

GODIR="$HOME/src/go"

# add go bin paths
PATH=$PATH:$GODIR/bin
PATH=$PATH:/usr/local/go/bin

# Add GOPATH
if [ -d $GODIR ] ; then
    export GOPATH=$GODIR
fi

if [ -d ${ASDFDIR} ] ; then
   . "${ASDFDIR}"
fi

if [ -f /usr/bin/virtualenvwrapper.sh ] || [ -f /usr/local/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/prog/python
    . /usr/bin/virtualenvwrapper.sh
fi

export XDG_RUNTIME_DIR="/tmp/"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/mitch/.lmstudio/bin"
# End of LM Studio CLI section

