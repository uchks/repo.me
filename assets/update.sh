#!/bin/bash

echo

./clean.sh

echo
echo "Rebuilding package list..."
echo "--------------------------"

rm -f Packages*
dpkg-scanpackages -m ./debians > Packages
bzip2 -k Packages
dpkg-scanpackages -m ./debians > Packages

echo "--------------------------"
echo "Done."
echo
