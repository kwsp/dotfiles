#!/usr/bin/env bash
set -e

CWD=$(cd "$(dirname "$0")" && pwd)
HOME_DIR=~
CONFIG_INSTALL_DIR="$HOME_DIR/.config"
OHMYZSH_DIR="$HOME_DIR/.oh-my-zsh"
OHMYTMUX_DIR="$HOME_DIR/.tmux"

echo "$(tput setaf 4)Hello!"

# Install oh my zsh
if [[ ! -d "$OHMYZSH_DIR" ]]; then
    echo "$(tput setaf 3)Installing Oh My Zsh . . ."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "$(tput setaf 2)Oh My Zsh already installed."
fi

# Install oh my tmux
if [[ -d "$OHMYTMUX_DIR" ]]; then
    echo "$(tput setaf 2)Oh My Tmux already installed."
else
    echo "$(tput setaf 3)Installing Oh My Tmux"
    cd
    git clone https://github.com/gpakosz/.tmux.git > /dev/null
    ln -s -f .tmux/.tmux.conf
    cd "$CWD"
fi

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
