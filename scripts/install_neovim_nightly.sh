#!/bin/bash
# Installs the nightly NeoVim app image to /opt and symlink to /usr/local/bin
# This is the easiest way to install NeoVim nightly on a distro that doesn't package it.

# Should be run as root
if [ "${EUID:-$(id -u)}" -ne 0 ]; then
	echo Please run as root.
	exit 1
fi

# Check if /opt/nvim exists
if [ ! -d /opt/nvim ]; then
	mkdir /opt/nvim
fi

# Download latest appimage
echo Downloading latest neovim appimage...
curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > /tmp/nvim.appimage
chmod a+x /tmp/nvim.appimage
echo Copying to /opt/nvim/nvim.appimage
mv /tmp/nvim.appimage /opt/nvim/nvim.appimage

# Symlink to /usr/local/bin
echo Symlinking /usr/local/bin/nvim to /opt/nvim/nvim.appimage
ln -sf /opt/nvim/nvim.appimage /usr/local/bin/nvim
