#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
# redirect stdout/stderr to a file
exec &>> $BASEDIR/log.txt

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date -Iseconds)" "$line";
    done
}

gitupdate() {
    CHANGED=$(git diff --name-only HEAD)
    if [[ $CHANGED ]]; then
        echo Changed files: $CHANGED
        #echo Uploading to github
        #git add . > /dev/null
        #git commit -m "Updated config $(date -Iseconds)" > /dev/null
        #git push > /dev/null
    else
        echo Nothing changed
    fi
}

main() {
    rsync -av ~/.config/i3* ~/.config/polybar ~/.config/plasma* config/
    rsync -av ~/.vimrc ~/.tmux.conf.local ~/.zshrc dotfiles

    gitupdate
}


main | adddate
echo
