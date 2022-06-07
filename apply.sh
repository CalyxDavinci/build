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

echo "[i] Fetching is done. Patching sources..."

cd frameworks/base
echo "[i] Applying 0001-core-jni-Switch-to-O3.patch"
git am -3 $CATHEDRA_PATH/patches/0001-core-jni-Switch-to-O3.patch
cd $BASE_BUILD_DIR

cd build/soong
echo "[i] Applying 0002-soong-clang-builds-with-O3.patch"
git am -3 $CATHEDRA_PATH/patches/0002-soong-clang-builds-with-O3.patch
cd $BASE_BUILD_DIR

cd build/tools
echo "[i] Applying 0005-build-add-erofs-support.patch"
git am -3 $CATHEDRA_PATH/patches/0005-build-add-erofs-support.patch
echo "[i] Applying 0007-releasetools-use-first-entry-of-mountpoint.patch"
git am -3 $CATHEDRA_PATH/patches/0007-releasetools-use-first-entry-of-mountpoint.patch
cd $BASE_BUILD_DIR

cd bionic
echo "[i] Applying 0003-libc-switch-to-jemalloc-from-scudo.patch"
git am -3 $CATHEDRA_PATH/patches/0003-libc-switch-to-jemalloc-from-scudo.patch
cd $BASE_BUILD_DIR

cd system/extras
echo "[i] Applying 0006-add-fstab-entry-for-erofs-postinstall.patch"
git am -3 $CATHEDRA_PATH/patches/0006-add-fstab-entry-for-erofs-postinstall.patch
cd $BASE_BUILD_DIR

cd vendor/calyx
echo "[i] Applying 0004-Use-bromite-instead-of-chromium-webview.patch"
git am -3 $CATHEDRA_PATH/patches/0004-Use-bromite-instead-of-chromium-webview.patch
echo "[i] Applying 0007-build-Flatten-APEXs-for-performance.patch"
git am -3 $CATHEDRA_PATH/patches/0007-build-Flatten-APEXs-for-performance.patch
echo "[i] Applying 0008-build-Set-ro.apex.updatable-false-in-product-propert.patch"
git am -3 $CATHEDRA_PATH/patches/0008-build-Set-ro.apex.updatable-false-in-product-propert.patch
cd $BASE_BUILD_DIR

cd prebuilts/clang/host/linux-x86
echo "[i] Applying 0001-No-scudo-prebuilts-since-clang-r437112.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-No-scudo-prebuilts-since-clang-r437112.patch
cd $BASE_BUILD_DIR

cd build/soong
echo "[i] Applying 0001-soong-Clang-14-15-Rust-1.61-backports.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-soong-Clang-14-15-Rust-1.61-backports.patch
cd $BASE_BUILD_DIR

cd build/make
echo "[i] Applying 0001-make-Change-llvm-ar-format-to-be-format.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-make-Change-llvm-ar-format-to-be-format.patch
cd $BASE_BUILD_DIR

cd external/harfbuzz_ng
echo "[i] Applying 0001-Do-not-use-pragma-diagnostics-as-a-workaround.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Do-not-use-pragma-diagnostics-as-a-workaround.patch
cd $BASE_BUILD_DIR

cd system/netd
echo "[i] Applying 0001-netd-Clang-15-backports.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-netd-Clang-15-backports.patch
cd $BASE_BUILD_DIR

cd external/mdnsresponder
echo "[i] Applying 0001-Increase-keyword-buffer-size-to-11-since-we-read-up-.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Increase-keyword-buffer-size-to-11-since-we-read-up-.patch
cd $BASE_BUILD_DIR

cd frameworks/base
echo "[i] Applying 0001-base-Clang-15-backports.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-base-Clang-15-backports.patch
cd $BASE_BUILD_DIR

cd system/apex
echo "[i] Applying 0001-Remove-redundant-using-statement.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Remove-redundant-using-statement.patch
cd $BASE_BUILD_DIR

cd frameworks/native
echo "[i] Applying 0001-libbinder-Remove-redundant-using-android.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-libbinder-Remove-redundant-using-android.patch
echo "[i] Applying 0002-Fix-error-for-compiler-update.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0002-Fix-error-for-compiler-update.patch
echo "[i] Applying 0003-binder-Fix-new-Rust-compiler-errors.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0003-binder-Fix-new-Rust-compiler-errors.patch
cd $BASE_BUILD_DIR

cd bionic
echo "[i] Applying 0001-Reland-Use-the-dynamic-table-instead-of-__rela-_iplt.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Reland-Use-the-dynamic-table-instead-of-__rela-_iplt.patch
cd $BASE_BUILD_DIR

cd frameworks/av
echo "[i] Applying 0001-MediaMetrics-fix-error-for-compiler-update.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-MediaMetrics-fix-error-for-compiler-update.patch
echo "[i] Applying 0002-Suppress-ordered-compare-function-pointers-warning.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0002-Suppress-ordered-compare-function-pointers-warning.patch
cd $BASE_BUILD_DIR

cd art
echo "[i] Applying 0001-Switch-to-an-assembler-macro-for-CFI_RESTORE_STATE_A.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Switch-to-an-assembler-macro-for-CFI_RESTORE_STATE_A.patch
echo "[i] Applying 0002-Suppress-three-counts-of-compiler-warnings-for-frame.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0002-Suppress-three-counts-of-compiler-warnings-for-frame.patch
cd $BASE_BUILD_DIR

cd packages/modules/DnsResolver
echo "[i] Applying 0001-Sanitize-buffer-alignment-macros.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Sanitize-buffer-alignment-macros.patch
echo "[i] Applying 0002-DnsResolver-Remove-redundant-using-statements.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0002-DnsResolver-Remove-redundant-using-statements.patch
cd $BASE_BUILD_DIR

cd prebuilts/rust
echo "[i] Applying 0001-rust-Backport-to-old-soong.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-rust-Backport-to-old-soong.patch
cd $BASE_BUILD_DIR

cd packages/modules/Connectivity
echo "[i] Applying 0001-Fix-deprecated-error-limit-linker-flag.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Fix-deprecated-error-limit-linker-flag.patch
cd $BASE_BUILD_DIR

cd system/bt
echo "[i] Applying 0001-bt-Ignore-unused-value-warnings.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-bt-Ignore-unused-value-warnings.patch
cd $BASE_BUILD_DIR

cd system/security
echo "[i] Applying 0001-Fix-warnings-in-preparation-for-Rust-1.54.0.patch"
git am -3 $CATHEDRA_PATH/patches/clang-15/0001-Fix-warnings-in-preparation-for-Rust-1.54.0.patch
cd $BASE_BUILD_DIR
