# Run this in a non-admin PowerShell

# install scoop to the user home directory
iwr -useb get.scoop.sh | iex

scoop install git
scoop bucket add extras
scoop install fzf ripgrep fd neovim
scoop install brave wezterm
