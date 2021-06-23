if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Disable bash deprecation warnings on BigSur
export BASH_SILENCE_DEPRECATION_WARNING=1

# Single ssh-agent session
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > $HOME/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<$HOME/.ssh-agent-thing)" > /dev/null
fi

# Display count of stopped processes (Ctrl+Z)
jobscount() {
  local stopped=$(jobs -sp | wc -l |tr -d '[:space:]')
  ((stopped)) && echo -n "(${stopped}) "
}

# Variables & Paths
export PS1='[\h] \w $(jobscount)\$ '
export PATH=$HOME/.local/bin:$HOME/.local/sbin:$PATH:/sbin
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE
export BROWSER="w3m"
export LC_ALL="en_US.UTF-8"

# Aliases
alias p="/usr/bin/env python"
if [[ `uname -s` == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
if command -v nvim > /dev/null 2>&1; then
    alias vim="nvim"
fi
if command -v rg > /dev/null 2>&1; then
    alias ffile='rg --files --hidden --no-ignore-vcs | rg "$@"'
fi

# pyenv & pyenv-virtualenv
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# Scripts & Functions
if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

notify(){
    # Reverse the string, so that the trigger doesn't fire when opening this
    # file
    echo 'vt78bhiu78t67iu' | rev
}
