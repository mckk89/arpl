#!/usr/bin/env bash

set -e

BR_VER="buildroot-2022.02.2"
if [ ! -d "${BR_VER}" ]; then
  echo "Downloading buildroot"
  curl -LO "https://buildroot.org/downloads/${BR_VER}.tar.gz"
  echo "Extracting buildroot"
  tar xf "${BR_VER}.tar.gz"
  rm "${BR_VER}.tar.gz"
fi
# Remove old files
rm -rf "${BR_VER}/output/target/opt/arpl"
rm -rf "${BR_VER}/board/arpl/overlayfs"
rm -rf "${BR_VER}/board/arpl/p1"
rm -rf "${BR_VER}/board/arpl/p3"
echo "Copying files"
cp -Ru files/* "${BR_VER}/"

cd "${BR_VER}"
echo "Generating default config"
make arpl_defconfig
echo "Building... Drink a coffee and wait!"
make
cd -
rm -f arpl.img.zip
zip -9 arpl.img.zip arpl.img