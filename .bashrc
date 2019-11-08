#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Single ssh-agent session
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > $HOME/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<$HOME/.ssh-agent-thing)"
fi

# Display count of stopped processes (Ctrl+Z)
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  ((stopped)) && echo -n "(${stopped}) "
}

# VARIABLES
export PS1='[\h] \w $(jobscount)\$ '
export PATH=$HOME/.local/bin:$HOME/.local/sbin:$PATH:/sbin
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE
export LC_ALL="en_US.UTF-8"

# ALIASES
alias p="/usr/bin/env python"
alias ll="ls -l"
if command -v nvim > /dev/null 2>&1; then
    alias vim="nvim"
fi
if command -v rg > /dev/null 2>&1; then
    alias ffile='rg --files --hidden --no-ignore-vcs | rg "$@"'
fi

# SCRIPTS
if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi
