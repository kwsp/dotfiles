#!/bin/bash
set -e

if [ -n "${GPG_KEY_B64:-}" ]; then
    echo "Importing GPG key..."
    echo "$GPG_KEY_B64" | base64 -d | gpg --batch --import
    # Mark all imported secret keys as ultimately trusted
    gpg --list-secret-keys --with-colons \
        | awk -F: '/^sec/{print $5":6:"}' \
        | gpg --import-ownertrust
    unset GPG_KEY_B64
fi

exec "$@"
