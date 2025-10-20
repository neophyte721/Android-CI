#!/usr/bin/env bash

git clone --recursive --depth=1 https://github.com/ClangBuiltLinux/tc-build $(pwd)/llvmTC -b main
cd $(pwd)/llvmTC

bash ci.sh deps

# Function to show an informational message
msg() {
    echo -e "\e[1;32m$*\e[0m"
}
err() {
    echo -e "\e[1;41$*\e[0m"
}

# Environment Config
export BRANCH=main
export CCACHE=1

# Get home directory
DIR="$(pwd ...)"
install=$DIR/install
src=$DIR/src

# Build Info
rel_date="$(date "+%Y%m%d")" # ISO 8601 format
rel_friendly_date="$(date "+%B %-d, %Y")" # "Month day, year" format
builder_commit="$(git rev-parse HEAD)"

# Building LLVM's
msg "Building LLVM's ..."
chmod +x build-llvm.py
./build-llvm.py \
    --bolt \
	--build-stage1-only \
    --build-target distribution \
	--projects clang lld polly bolt compiler-rt \
	--lto thin \
    --pgo llvm \
    --defines LLVM_PARALLEL_COMPILE_JOBS="$(nproc)" LLVM_PARALLEL_LINK_JOBS="$(nproc)" CMAKE_C_FLAGS=-O3 CMAKE_CXX_FLAGS=-O3 \
    --install-folder "$install" \
    --quiet-cmake \
    --shallow-clone \
    --targets ARM AArch64 X86 \
    --ref "release/18.x" \
    --vendor-string "$LLVM_NAME" 2>&1 | tee build.log

# Check if the final clang binary exists or not.
[ ! -f install/bin/clang-1* ] && {
	err "Building LLVM failed ! Kindly check errors !!"
	err "build.log" "Error Log"
	exit 1
}

# Build binutils
msg "Build binutils ..."
chmod +x build-binutils.py
./build-binutils.py \
    --install-folder "$install" \
    --targets arm aarch64 x86_64

rm -fr install/include
rm -f install/lib/*.a install/lib/*.la

for f in $(find install -type f -exec file {} \; | grep 'not stripped' | awk '{print $1}'); do
    strip -s "${f::-1}"
done

for bin in $(find install -mindepth 2 -maxdepth 3 -type f -exec file {} \; | grep 'ELF .* interpreter' | awk '{print $1}'); do
    bin="${bin::-1}"

    echo "$bin"
    patchelf --set-rpath "$DIR/../lib" "$bin"
done

# Git config
git config --global user.name "neophyte"
git config --global user.email "alprjkt@gmail.com"

# Release Info
pushd "$src"/llvm-project || exit
llvm_commit="$(git rev-parse HEAD)"
short_llvm_commit="$(cut -c-8 <<<"$llvm_commit")"
popd || exit

llvm_commit_url="https://github.com/llvm/llvm-project/commit/$short_llvm_commit"
binutils_ver="$(ls | grep "^binutils-" | sed "s/binutils-//g")"
clang_version="$(install/bin/clang --version | head -n1 | cut -d' ' -f4)"

# Push to GitHub
# Update Git repository
git clone "https://neophyte721:$GH_TOKEN@github.com/neophyte721/neophyte-clang" rel_repo
pushd rel_repo || exit
rm -fr ./*
cp -r ../install/* .
git lfs install
git lfs track "clang-18"
git lfs track "opt"
git lfs track "clang-linker-wrapper"
git lfs track "clang-repl"
git lfs track "llc"
git lfs track "llvm-lto2"
git lfs track "llvm-lto"
git lfs track "libLTO.so"
git lfs track "bugpoint"
git lfs track "clang-scan-deps"
git lfs track "lld"
git lfs track "libclang.so.18.1.8"
git lfs track "libclang-cpp.so.18.1"
git checkout README.md # keep this as it's not part of the toolchain itself
git add .
git commit -asm "neophyte: Update to $rel_date build
LLVM commit: $llvm_commit_url
Clang Version: $clang_version
Binutils version: $binutils_ver
Builder commit: https://github.com/neophyte721/neophyte-clang/commit/$builder_commit"
git push
popd || exit
