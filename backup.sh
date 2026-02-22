#!/usr/bin/env bash

UNAME=$(uname)

# cd into script dir
BASEDIR=$(dirname "$0")
cd "$BASEDIR"

# redirect stdout/stderr to a file
#exec &>> log.txt

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date)" "$line";
    done
}

main() {
    echo "Starting backup ..."

    # backup config
    rsync -av ~/.config/sway ~/.config/waybar ~/.config/kitty ~/.config/nvim ~/.config/zathura ~/.config/fastfetch config
    # backup dotfiles
    rsync -av ~/.tmux.conf.local ~/.zshrc ~/.gitconfig dotfiles/

    echo "Backup complete."
}


main "$@" | adddate
echo
