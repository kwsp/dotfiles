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

### Zsh specific config
# Zsh tetris
autoload -Uz tetriscurses
# No autocd for directories
unsetopt autocd

### General configuration
export EDITOR=nvim
alias vim=nvim
export GIT_EDITOR=nvim

alias :q='echo "Nerd..." && sleep 1 && exit'
alias :e='echo "Nerd..." && sleep 1 && vim'

# Local bin
export PATH=$PATH:~/.local/bin


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias p1='ping 1.1.1.1'

# add some scripts to path
export PATH=$PATH:~/dotfiles/scripts


### Platform specific setup
case "$(uname -s)" in
  Linux*) 
    alias open=xdg-open
    ;;

  Darwin*)
    ### macOS specific setup
    #
    # homebrew paths

    export LIBRARY_PATH=/opt/homebrew/lib/

    # Use LLVM from homebrew
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export CC=clang
    export CXX=clang++

    # Vulkan SDK
    export VULKAN_SDK=~/VulkanSDK/1.3.275.0/macOS
    export PATH=$VULKAN_SDK/bin:$PATH
    export DYLD_LIBRARY_PATH=$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
    export VK_ICD_FILENAMES=$VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
    export VK_LAYER_PATH=$VULKAN_SDK/share/vulkan/explicit_layer.d

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ;;

esac

export PATH=~/.nimble/bin:$PATH

# VCPKG
export PATH=~/vcpkg:$PATH
export VCPKG_ROOT=~/vcpkg
autoload bashcompinit
bashcompinit
source /Users/tnie/vcpkg/scripts/vcpkg_completion.zsh
