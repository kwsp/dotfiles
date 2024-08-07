# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'
#alias vim='nvim'
alias :q='echo "Nerd..." && sleep 1 && exit'
alias :e='echo "Nerd..." && sleep 1 && vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Local bin
export PATH=$PATH:~/.local/bin

# Flatpak
export PATH=$PATH:/var/lib/flatpak/app

# GO path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Golang tools
export PATH=$PATH:/usr/local/go/bin

# Open command
case "$(uname -s)" in
    Linux*) alias open=xdg-open;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zsh tetris
autoload -Uz tetriscurses

# No autocd for directories
unsetopt autocd

# Autocomplete java classes in the current directory
export CLASSPATH=.:$CLASSPATH

## Booting into TTY
# Gruvbox
#if [ "$TERM" = "linux" ]; then
  #/bin/echo -e "
  #\e]P0282828
  #\e]P1cc241d
  #\e]P298971a
  #\e]P3d79921
  #\e]P4458588
  #\e]P5b16286
  #\e]P6689b6a
  #\e]P7a89984
  #\e]P8928374
  #\e]P9fb4934
  #\e]PAb8bb26
  #\e]PBfabd2f
  #\e]PC83a598
  #\e]PDd3869b
  #\e]PE8ec07c
  #\e]PFebdbb2
  #"
  ## get rid of artifacts
  #clear
#fi

# Colour for man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

