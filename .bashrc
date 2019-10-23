if [ -f /etc/bashrc ]; then
    . /etc/bashrc

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
fi

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

# Basic paths
export PATH=$HOME/local/bin:$HOME/local/sbin:$PATH:/sbin
export PS1='[\h] \w $(jobscount)\$ '
alias p="/usr/bin/env python"

# Custom pager for PostgreSQL
export PAGER=less
export LESS="-iMSx4 -FX"

# Git auto completion
. ~/.git-completion.bash
