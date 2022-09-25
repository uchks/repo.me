#!/usr/bin/env bash
script_full_path=$(dirname "$0")

if [[ "$OSTYPE" == "linux"* ]]; then # Linux usage of repo.me
    cd $script_full_path || exit 1
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Packages.lz4 Packages.lzma Release Release.gpg InRelease 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    xz -5fkev --format=lzma Packages > Packages.lzma
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2  
    lz4 -c9 Packages > Packages.lz4
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" == i386 ]]; then # macOS usage of repo.me
    cd $script_full_path || exit 1
    
    echo "Checking for Homebrew, wget, xz, & zstd..."
    if test ! "$(which brew)"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew list --verbose wget || brew install wget
    brew list --verbose xz || brew install xz
    brew list --verbose zstd || brew install zstd
    clear
    
    echo "apt-ftparchive compiled by Diatrus" # credits to Hayden!
    wget -q -nc https://apt.procurs.us/apt-ftparchive 
    sudo chmod 751 ./apt-ftparchive # could change this to be pointed in documentation, but people don't like to read what needs READING. i'll think about it later.
    
    rm {Packages{,.xz,.gz,.bz2,.zst,.lz4,.lzma},Release{,.gpg},InRelease} 2> /dev/null
    
    ./apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    xz -5fkev --format=lzma Packages > Packages.lzma
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2  
    lz4 -c9 Packages > Packages.lz4

    
    ./apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname -r)" == *Microsoft ]]; then # WSL 1 usage of repo.me
    cd $script_full_path || exit 1
    
    rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Packages.lz4 Packages.lzma Release Release.gpg InRelease 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    xz -5fkev --format=lzma Packages > Packages.lzma
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2  
    lz4 -c9 Packages > Packages.lz4
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname -r)" == *microsoft-standard ]]; then # WSL 2 usage of repo.me
    cd $script_full_path || exit 1
    
    rm {Packages{,.xz,.gz,.bz2,.zst,.lz4,.lzma},Release{,.gpg},InRelease} 2> /dev/null
    
    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    xz -5fkev --format=lzma Packages > Packages.lzma
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2  
    lz4 -c9 Packages > Packages.lz4
    
    apt-ftparchive release -c ./assets/repo/repo.conf . > Release
    
    echo "Repository Updated, thanks for using repo.me!"
    elif [[ "$(uname)" == Darwin ]] && [[ "$(uname -p)" != i386 ]]; then # iOS/iPadOS usage of repo.me
    cd $script_full_path || exit 1
    echo "Checking for apt-ftparchive..."
    if test ! "$(apt-ftparchive)"; then
        apt update && apt install apt-utils -y
    fi

    rm {Packages{,.xz,.gz,.bz2,.zst,.lz4,.lzma},Release{,.gpg},InRelease} 2> /dev/null

    apt-ftparchive packages ./debians > Packages
    gzip -c9 Packages > Packages.gz
    xz -c9 Packages > Packages.xz
    xz -5fkev --format=lzma Packages > Packages.lzma
    zstd -c19 Packages > Packages.zst
    bzip2 -c9 Packages > Packages.bz2  
    lz4 -c9 Packages > Packages.lz4

    apt-ftparchive release -c ./assets/repo/repo.conf . > Release

    echo "Repository Updated, thanks for using repo.me!"
else
    echo "Running an unsupported operating system...? Contact me via Twitter @localdevice" # incase I've missed support for something, they should be contacting me.
fi
