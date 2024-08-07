#!/usr/bin/env bash

UNAME=$(uname)

# cd into script dir
BASEDIR=$(dirname "$0")
cd $BASEDIR

# redirect stdout/stderr to a file
#exec &>> log.txt

adddate() {
    while IFS= read -r line; do
        printf '%s %s\n' "$(date)" "$line";
    done
}

gitupdate() {

    if [[ $# = 0 ]]; then
        echo "no args"
        commit_msg="Updated config $(date)"
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

    # backup config
    rsync -q -av ~/.config/sway ~/.config/kitty ~/.config/nvim ~/.config/zathura config
    # backup dotfiles
    rsync -q -av ~/.tmux.conf.local ~/.zshrc ~/.gitconfig dotfiles/

    if [[ $UNAME = "Darwin" ]]; then
        echo Backing up Darwin specific config.
        # backup pecan
        PECAN_DIR="$HOME/Library/Application Support/Übersicht/widgets/pecan"
        cp "$PECAN_DIR/style.css" pecan/
        cp "$PECAN_DIR/halcyon.css" pecan/
    fi

    #gitupdate $1
    echo "Backup complete."
}


main $@ | adddate
echo
