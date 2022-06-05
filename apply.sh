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
rm -rf prebuilts/clang/host/linux-x86/adrian-clang-2
mkdir -p prebuilts/clang/host/linux-x86/adrian-clang-2
cd prebuilts/clang/host/linux-x86/adrian-clang-2
curl https://ftp.travitia.xyz/clang/clang-r459371.tar.xz | tar -xJ
cd $BASE_BUILD_DIR

echo "[i] Fetching is done. Patching sources..."

cd frameworks/base
echo "[i] Applying 0001-core-jni-Switch-to-O3.patch"
git am -3 $CATHEDRA_PATH/patches/0001-core-jni-Switch-to-O3.patch
cd $BASE_BUILD_DIR

cd build/soong
echo "[i] Applying 0002-soong-clang-builds-with-O3.patch"
git am -3 $CATHEDRA_PATH/patches/0002-soong-clang-builds-with-O3.patch
cd $BASE_BUILD_DIR

cd bionic
echo "[i] Applying 0003-libc-switch-to-jemalloc-from-scudo.patch"
git am -3 $CATHEDRA_PATH/patches/0003-libc-switch-to-jemalloc-from-scudo.patch
cd $BASE_BUILD_DIR

cd vendor/calyx
echo "[i] Applying 0004-Use-bromite-instead-of-chromium-webview.patch"
git am -3 $CATHEDRA_PATH/patches/0004-Use-bromite-instead-of-chromium-webview.patch
cd $BASE_BUILD_DIR
