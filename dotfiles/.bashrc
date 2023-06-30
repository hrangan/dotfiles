if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

###############
# OS SPECIFIC #
###############

case "$(uname -s)" in

   Darwin)
     alias ls='ls -G'

     # Disable bash deprecation warnings on BigSur
     export BASH_SILENCE_DEPRECATION_WARNING=1
     ;;

   Linux)
     alias ls='ls --color=auto'

     # Single ssh-agent session
     if ! pgrep -u "$USER" ssh-agent > /dev/null; then
         ssh-agent > $HOME/.ssh-agent-thing
     fi
     if [[ "$SSH_AGENT_PID" == "" ]]; then
         eval "$(<$HOME/.ssh-agent-thing)" > /dev/null
     fi
     ;;

   *)
     echo 'ERROR:.bashrc: Unknown OS, validate configuration manually'
     ;;
esac

##################
# INITIALIZATION #
##################


eval "$(/opt/homebrew/bin/brew shellenv)"

#############
# FUNCTIONS #
#############

# Display count of stopped processes (Ctrl+Z)
jobscount() {
  local stopped=$(jobs -sp | wc -l |tr -d '[:space:]')
  ((stopped)) && echo -n "(${stopped}) "
}

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

#############
# VARIABLES #
#############

export EDITOR='nvim'
export PS1='[\h][${timer_show}s] \w $(jobscount)\$ '
export PATH=$HOME/.local/bin:$HOME/.local/sbin:$PATH:/sbin
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE
export BROWSER="w3m"
export LC_ALL="en_US.UTF-8"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

###########
# ALIASES #
###########

alias p="/usr/bin/env python"

if command -v nvim > /dev/null 2>&1; then
    alias vim="nvim"
fi

if command -v rg > /dev/null 2>&1; then
    alias ffile='rg --files --hidden --no-ignore-vcs | rg "$@"'
fi

####################
# COMMAND SPECIFIC #
####################

if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

if command -v heroku 1>/dev/null 2>&1; then
    HEROKU_AC_BASH_SETUP_PATH=/Users/hrangan/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
fi

#####################
# PLANVIEW SPECIFIC #
#####################

if command -v yarn > /dev/null 2>&1; then
    export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"
    alias y='yarn --cwd /Users/hrangan/sources/main_service/frontend/harmony'
    alias yd='yarn --cwd /Users/hrangan/sources/main_service/frontend/harmony dev --notify'
fi

[[ -s "/Users/hrangan/sources/main_service/localenv/ppdev-bash-init.sh" ]] && source "/Users/hrangan/sources/main_service/localenv/ppdev-bash-init.sh"
export USE_COMPOSE=1


### PPDEV INSTALLED - read init script
[[ -s "/Users/hrangan/sources/main_service/localenv/ppdev-bash-init.sh" ]] && source "/Users/hrangan/sources/main_service/localenv/ppdev-bash-init.sh"
