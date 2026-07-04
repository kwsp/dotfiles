#!/usr/bin/env bash
set -e

CWD=$(cd "$(dirname "$0")" && pwd)
HOME_DIR=~
CONFIG_INSTALL_DIR="$HOME_DIR/.config"
OHMYZSH_DIR="$HOME_DIR/.oh-my-zsh"
TPM_DIR="$HOME_DIR/.tmux/plugins/tpm"

echo "$(tput setaf 4)Hello!"

# Install oh my zsh
if [[ ! -d "$OHMYZSH_DIR" ]]; then
    echo "$(tput setaf 3)Installing Oh My Zsh . . ."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "$(tput setaf 2)Oh My Zsh already installed."
fi

# Install TPM (Tmux Plugin Manager)
if [[ -d "$TPM_DIR" ]]; then
    echo "$(tput setaf 2)TPM already installed."
else
    echo "$(tput setaf 3)Installing TPM . . ."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" > /dev/null
fi

# Install rose-pine-man
mkdir -p ~/.config/zsh/
pushd ~/.config/zsh
if [[ ! -d "rose-pine-man" ]]; then
    echo "$(tput setaf 3)Installing rose-pine-man"
    git clone https://github.com/const-void/rose-pine-man.git
fi
popd

# Install dotfiles
echo "$(tput setaf 3)Copying dotfiles to $HOME_DIR . . ."
cp -r "$CWD/dotfiles/." "$HOME_DIR"

# Install config
[ -d "$CONFIG_INSTALL_DIR" ] || mkdir "$CONFIG_INSTALL_DIR"
echo "$(tput setaf 3)Copying config files to $CONFIG_INSTALL_DIR . . ."
cp -r "$CWD/config/." "$CONFIG_INSTALL_DIR"

### Install platform specific config
case "$(uname -s)" in
  Linux*)
    ;;

  Darwin*)
    ;;
esac

echo
echo "$(tput setaf 2)Done ✨"
