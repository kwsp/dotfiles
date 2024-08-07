#!/usr/bin/env bash

HOME_DIR=~
CONFIG_INSTALL_DIR=$HOME_DIR/.config/
OHMYZSH_DIR=$HOME_DIR/.oh-my-zsh
OHMYTMUX_DIR=$HOME_DIR/.tmux
CWD=$(pwd)

echo WORKDIR: $CWD

# Install oh my zsh
[[ -z "${ZSH}" ]] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install oh my tmux
if [[ -d "$OHMYTMUX_DIR" ]]; then
    echo Oh My Tmux already installed, skipping.
else
    echo Installing Oh My Tmux
    cd
    git clone https://github.com/gpakosz/.tmux.git > /dev/null
    ln -s -f .tmux/.tmux.conf
    cd $CWD
fi

# Install dotfiles
echo "Copying dotfiles to $HOME_DIR"
cp -r $CWD/dotfiles/. $HOME_DIR

# Install config
[ -d $CONFIG_INSTALL_DIR ] || mkdir $CONFIG_INSTALL_DIR
echo "Copying config files to $CONFIG_INSTALL_DIR"
cp -r $CWD/.config/* $CONFIG_INSTALL_DIR
