if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Single ssh-agent session
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" 1> /dev/null
fi

# Display count of stopped processes (Ctrl+Z)
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  ((stopped)) && echo -n "(${stopped}) "
}

# Basic paths
export PATH=$HOME/local/bin:$HOME/local/sbin:$PATH:/sbin
export PS1='[\h] \w $(jobscount)\$ '
alias p="/usr/bin/env python"

# Cusomt pager for PostgreSQL
export PAGER=less
export LESS="-iMSx4 -FX"

# Git auto completion
. ~/.git-completion.bash
