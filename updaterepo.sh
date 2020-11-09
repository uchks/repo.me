#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux"* ]]; then # Linux usage of repo.me
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" == i386 ]]; then # macOS usage of repo.me
    cd "$(dirname "$0")" || exit
    
    echo "Checking for Homebrew, wget, xz, & zstd..."
    if test ! "$(which brew)"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew list --verbose wget || brew install wget
    brew list --verbose xz || brew install xz
    brew list --verbose zstd || brew install zstd
    clear
    
    echo "apt-ftparchive compiled by @Diatrus" # credits to Hayden!
    wget -q -nc https://apt.procurs.us/apt-ftparchive # assuming Homebrew is already installed, download apt-ftparchive via wget
    sudo chmod 751 ./apt-ftparchive # could change this to be pointed in documentation, but people don't like to read what needs READING. i'll think about it later.
    
    rm {Packages{,.xz,.gz,.bz2,.zst},Release{,.gpg}} 2> /dev/null
    
    ./apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    ./apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname -r)" == *Microsoft ]]; then # WSL 1 usage of repo.me
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname -r)" == *microsoft-standard ]]; then # WSL 2 usage of repo.me
    cd "$(dirname "$0")" || exit
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" != i386 ]]; then # iOS/iPadOS usage of repo.me
    cd "$(dirname "$0")" || exit
    echo "Checking for apt-ftparchive..."
    if test ! "$(apt-ftparchive)"; then
        apt update && apt install apt-utils -y
    fi

    rm {Packages{,.xz,.gz,.bz2,.zst},Release{,.gpg}} 2> /dev/null

    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2

    apt-ftparchive release -c ./assets/repo/repo.conf . > Release

    echo "Repository Updated, thanks for using repo.me!"
else
    echo "Running an unsupported operating system...? Contact me via Twitter @truesyns" # incase I've missed support for something, they should be contacting me.
fi
