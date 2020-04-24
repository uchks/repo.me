#!/bin/bash
script_full_path=$(dirname "$0")
cd $script_full_path

rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release

apt-ftparchive packages ./debians > Packages
gzip -c9 Packages > Packages.gz
xz -c9 Packages > Packages.xz
zstd -c19 Packages > Packages.zst
bzip2 -c9 Packages > Packages.bz2

apt-ftparchive release -c ./assets/repo/repo.conf . > Release

echo "Updated."
