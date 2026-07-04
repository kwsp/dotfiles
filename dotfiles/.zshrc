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
if command -v nvim &>/dev/null; then
    export EDITOR=nvim
    alias vim=nvim
else
    export EDITOR=vim
fi
export GIT_EDITOR=$EDITOR

alias :q='echo "Nerd..." && sleep 1 && exit'
alias :e='echo "Nerd..." && sleep 1 && vim'
alias p1='ping 1.1.1.1'
alias rsyncone='rsync -avz --partial --stats --progress'

# add some scripts to path
export PATH=$PATH:~/dotfiles/scripts


### Platform specific setup
case "$(uname -s)" in
  Linux*) 
    alias open=xdg-open

    # CUDA Toolkit
    if [ -d /usr/local/cuda ]; then
      export PATH=/usr/local/cuda/bin:$PATH
      export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    fi

    # linuxbrew
    if [ -d /home/linuxbrew/.linuxbrew ]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
    fi

    ;;

  Darwin*)
    ### macOS specific setup
    export CC=clang
    export CXX=clang++

    ### Add Homebrew LLVM to path
    export PATH=$(brew --prefix llvm)/bin:$PATH

    ### Use Homebrew LLVM bundled libc++
    #export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
    ## For compilers to find llvm you may need to set:
    #export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
    #export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

    ## Put Apple Clang before LLVM clang
    export PATH=/usr/bin:$PATH

    # For compilers to find homebrew libs
    export LDFLAGS="-L/opt/homebrew/lib"
    export CPPFLAGS="-I/opt/homebrew/include"

    # For CMake to find homebrew packages
    export CMAKE_PREFIX_PATH=/opt/homebrew

    # Vulkan SDK
    export VULKAN_SDK=~/VulkanSDK/1.3.275.0/macOS
    export PATH=$VULKAN_SDK/bin:$PATH
    export DYLD_LIBRARY_PATH=$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
    export VK_ICD_FILENAMES=$VULKAN_SDK/share/vulkan/icd.d/MoltenVK_icd.json
    export VK_LAYER_PATH=$VULKAN_SDK/share/vulkan/explicit_layer.d

    # Use coreutils ls if available
    if command -v gls &>/dev/null; then
      alias ls='gls --color --hyperlink=auto'
      alias l='gls --color --hyperlink=auto -lah'
    fi

    # pnpm
    export PNPM_HOME="~/Library/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end

    ;;
esac

if [ -d ~/vcpkg ]; then
  # VCPKG
  export PATH=~/vcpkg:$PATH
  export VCPKG_ROOT=~/vcpkg
  autoload bashcompinit
  bashcompinit
  source $VCPKG_ROOT/scripts/vcpkg_completion.zsh
fi

# Ensure GPG can use the terminal for passphrase input
export GPG_TTY=$(tty)

# fzf
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Docker CLI completions.
if [ -f "$HOME/.docker/completions/zsh/docker" ]; then
  source "$HOME/.docker/completions/zsh/docker"
fi

# bun
if [ -d "$HOME/.bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"

  # bun completions
  [ -s "~/.bun/_bun" ] && source "~/.bun/_bun"
fi 


alias cdbin='cd bin/linux-pc/relwithdebinfo'
