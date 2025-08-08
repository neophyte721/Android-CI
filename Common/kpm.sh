echo "Starting kernel patching process..."

# Change to kernel directory
cd $OUT_DIR/arch/arm64/boot/ || {
    echo "Error: Failed to enter kernel directory!" >&2
    exit 1
}

# Download patcher
echo "Downloading patcher..."
wget -q https://github.com/SukiSU-Ultra/SukiSU_KernelPatch_patch/releases/download/0.12.0/patch_linux || {
    echo "Error: Failed to download patcher!" >&2
    exit 1
}

# Make patcher executable
chmod +x patch_linux

# Execute patcher
echo "Patching kernel image..."
./patch_linux || {
    echo "Error: Patching failed!" >&2
    exit 1
}

# Replace original image
rm -f Image
mv oImage Image
