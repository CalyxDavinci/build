#!/bin/bash

source build/envsetup.sh

SCRIPT_PATH=$(realpath $0)
CATHEDRA_PATH=$(dirname $SCRIPT_PATH)
BASE_BUILD_DIR=$(pwd)

echo "[i] Fetching latest Adrian Clang build for the ROM build..."
rm -rf prebuilts/clang/host/linux-x86/adrian-clang
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang
cd prebuilts/clang/host/linux-x86/adrian-clang
curl https://ftp.travitia.xyz/clang/clang-latest.tar.xz | tar -xJ
cd $BASE_BUILD_DIR

echo "[i] Fetching Rust 1.66.0 build for the ROM build..."
rm -rf prebuilts/rust/linux-x86/1.66.0
mkdir -p prebuilts/rust/linux-x86/1.66.0
cd prebuilts/rust/linux-x86/1.66.0
curl https://ftp.travitia.xyz/clang/rust-1-66-0.tar.xz | tar -xJ
cd $BASE_BUILD_DIR

# Temporary picks until they get merged upstream
repopick -p 12848                    # Themed icon setting in launcher

$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches
$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches/rust-1.66
$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches/clang-16
