#!/bin/bash
MOUNTS=()
[[ -d "$HOME/.ssh" ]]   && MOUNTS+=(-v "$HOME/.ssh:/home/tnie/.ssh:ro")
[[ -d "$HOME/.gnupg" ]] && MOUNTS+=(-v "$HOME/.gnupg:/home/tnie/.gnupg:ro")

docker run -it --rm \
    "${MOUNTS[@]}" \
    -v "$(pwd):/workspace" \
    -w /workspace \
    kwsp/dotfiles
