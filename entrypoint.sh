#!/bin/bash

#######################################
# Extremely simple build script to
#    build CalyxOS for davinci
# error handling is not yet done,
#    manual review is required
#
# Requires AOSP tree at /aosp-src
# build patches at /cathedra
# and tmpfs at /build
#######################################

set -e

BUILDER_USER="calyx-davinci"
BUILDER_EMAIL="not@existing.org"
CACHE_SIZE="100GB"
BUILD_TYPE="user"
THREAD_COUNT=$(nproc --all)

echo "[i] Setting up ccache..."

export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
mkdir -p /build/ccache
export CCACHE_DIR="/build/ccache"
ccache -M $CACHE_SIZE

export HOME=/build

cd /aosp-src

echo "[i] Setting build environment..."

source build/envsetup.sh

lunch calyx_davinci-$BUILD_TYPE

echo "[i] Regenerating ABI reference dumps for O3 build..."
development/vndk/tools/header-checker/utils/create_reference_dumps.py -products calyx_davinci --build-variant $BUILD_TYPE

echo "[i] Starting build process..."

make -j$THREAD_COUNT otapackage

echo "[i] Done building!"
