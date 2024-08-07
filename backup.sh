#!/usr/bin/env bash

# cd into script dir
BASEDIR=$(dirname "$0")
cd $BASEDIR

# redirect stdout/stderr to a file
exec &>> log.txt

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date -Iseconds)" "$line";
    done
}

gitupdate() {

    if [[ $# = 0 ]]; then
        echo "no args"
        commit_msg="Updated config $(date -Iseconds)"
    else
        commit_msg=$1
    fi

    changed=$(git diff --name-only HEAD)
    if [[ $changed ]]; then
        echo changed files: $changed
        echo uploading to github
        git add . > /dev/null
        git commit -m "$commit_msg" > /dev/null
        git push > /dev/null
    else
        echo nothing changed
    fi
}

main() {
    echo "Starting backup ..."
    rsync -q -av ~/.config/sway ~/.config/zathura ~/.config/redshift ~/.config/deadd ~/.config/kitty ~/.config/nvim ~/.config/i3* ~/.config/polybar ~/.config/rofi ~/.config/compton .config
    rsync -q -av ~/.Xdefaults ~/.vimrc ~/.tmux.conf.local ~/.zshrc ~/.gitconfig ~/.xinitrc dotfiles/

    gitupdate $1
    echo "Backup complete."
}


main $@ | adddate
echo
