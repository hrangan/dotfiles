#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Single ssh-agent session
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# Display count of stopped processes (Ctrl+Z)
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  ((stopped)) && echo -n "(${stopped}) "
}

export PATH=$HOME/.local/bin:$HOME/.local/sbin:$PATH:/sbin
export PS1='[\h] \w $(jobscount)\$ '
export LC_ALL="en_US.UTF-8"
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

# Basic aliases
alias p="/usr/bin/env python"
alias ll="ls -l"
# alias vim="nvim"

# Git auto completion
. ~/.git-completion.bash
