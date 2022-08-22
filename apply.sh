#!/bin/bash

SCRIPT_PATH=$(realpath $0)
CATHEDRA_PATH=$(dirname $SCRIPT_PATH)
BASE_BUILD_DIR=$(pwd)

echo "[i] Fetching latest Adrian Clang build for the ROM build..."
# adrian-clang is used for building AOSP
rm -rf prebuilts/clang/host/linux-x86/adrian-clang
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang
cd prebuilts/clang/host/linux-x86/adrian-clang
curl https://ftp.travitia.xyz/clang/clang-latest.tar.xz | tar -xJ
cd $BASE_BUILD_DIR
# adrian-clang-2 is used for building the kernel
rm -rf prebuilts/clang/host/linux-x86/adrian-clang-2
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang-2
cd prebuilts/clang/host/linux-x86/adrian-clang-2
curl https://ftp.travitia.xyz/clang/clang-abce7acebd4c06c977bc4bd79170697f1122bc5e.tar.xz | tar -xJ
cd $BASE_BUILD_DIR

$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches
$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches/clang-16
