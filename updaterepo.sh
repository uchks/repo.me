#!/usr/bin/env bash

set -e
cd "$(dirname "$0")" || exit

needed=()
toInstall=(
    "xz"
    "zstd"
)

if [[ "$(uname)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "x86_64" ]]; then
        echo "Checking for Homebrew, wget, xz, & zstd..."
        if test ! "$(which brew)"; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi

        echo "apt-ftparchive compiled by @Diatrus" # credits to Hayden!
        wget -q -nc https://apt.procurs.us/apt-ftparchive # assuming Homebrew is already installed, download apt-ftparchive via wget
        chmod 0755 ./apt-ftparchive
        FTPARCHIVE='./apt-ftparchive'

        if [[ ! -z "${needed[@]}" ]]; then
            read -p "$(printf -- "Using Homebrew to install:\n%s\n  Press Enter to Continue. " "${needed[@]}")"
        fi

        for depend in ${needed[@]}; do
            brew install "${depend}"
        done
    fi
    # Leave room for arm macs.
else
        if test ! "$(which apt-ftparchive)"; then
            echo "Please install apt-utils."
            exit 1
        fi

        FTPARCHIVE='apt-ftparchive'

        if [[ ! -z "${needed[@]}" ]]; then
            printf -- "Please install:\n%s\n" "${needed[@]}" && exit 1
        fi
fi

rm -f {Packages{,.xz,.zst},Release{,.gpg}}

$FTPARCHIVE packages ./debians > Packages 2>/dev/null
xz -c9 Packages > Packages.xz
zstd -c19 Packages > Packages.zst

$FTPARCHIVE release -c ./assets/repo/repo.conf . > Release 2>/dev/null

echo "Repository Updated, thanks for using repo.me!"
