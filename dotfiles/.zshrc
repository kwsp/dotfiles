# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
alias vim='nvim'
export GIT_EDITOR=nvim

alias :q='echo "Nerd..." && sleep 1 && exit'
alias :e='echo "Nerd..." && sleep 1 && vim'

# Local bin
export PATH=$PATH:~/.local/bin

case "$(uname -s)" in
  Linux*) alias open=xdg-open;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zsh tetris
autoload -Uz tetriscurses

# No autocd for directories
unsetopt autocd

export PATH=$PATH:~/dotfiles/scripts

alias p1='ping 1.1.1.1'
alias ca='conda activate'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tnie/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tnie/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tnie/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tnie/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export LIBRARY_PATH=/opt/homebrew/lib/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:~/.cargo/bin
