#!/bin/bash

SCRIPT_PATH=$(realpath $0)
CATHEDRA_PATH=$(dirname $SCRIPT_PATH)
BASE_BUILD_DIR=$(pwd)

echo "[i] Fetching latest Adrian Clang build for the kernel build..."
# fresh clang toolchain by Adrian
rm -rf prebuilts/clang/host/linux-x86/adrian-clang
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang
cd prebuilts/clang/host/linux-x86/adrian-clang
# in case of automated builds, please host a mirror
curl https://ftp.travitia.xyz/clang/clang-latest.tar.xz | tar -xJ
cd $BASE_BUILD_DIR
rm -rf prebuilts/clang/host/linux-x86/adrian-clang-2
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang-2
cd prebuilts/clang/host/linux-x86/adrian-clang-2
curl https://ftp.travitia.xyz/clang/clang-r459371.tar.xz | tar -xJ
cd $BASE_BUILD_DIR

$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches
$CATHEDRA_PATH/apply.py $CATHEDRA_PATH/patches/clang-15
