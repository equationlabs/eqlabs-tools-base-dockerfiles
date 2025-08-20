#!/bin/sh

# This script is designed to be compatible with POSIX-compliant shells like Ash (used in Alpine).

# A single string variable with a space-separated list of supported architectures.
SUPPORTED_ARCHITECTURES="x86_64 aarch64"

# Get the current machine's architecture.
CURRENT_ARCH=$(uname -m)

# Standardize architecture names to a format we can match.
case "$CURRENT_ARCH" in
x86_64) 
    CURRENT_ARCH="x86_64"
    CORRECT_BINARY="php-static-cli-${PHP}-amd64.zip"
    ;; 
aarch64) 
    CURRENT_ARCH="aarch64"
    CORRECT_BINARY="php-static-cli-${PHP}-arm64.zip"
    ;; 
*) 
    echo "Error: Unsupported architecture '${CURRENT_ARCH}'." >&2
    exit 1
    ;; 
esac

echo "Detected architecture: ${CURRENT_ARCH}"

# Create the destination directory if it doesn't exist
mkdir -p /workspace/bin

echo "Unzipping package and copying binary..."
unzip "/workspace/builds/${CORRECT_BINARY}" -d "/tmp/unzipped"

# The original script attempts to copy from /workspace/builds. Assuming the unzipped binary is already there.
cp "/workspace/builds/${CORRECT_BINARY}" "/workspace/bin/php"

# Make the copied binary executable.
echo "Making binary executable..."
chmod +x "/workspace/bin/php"

# Clean up the build directory.
echo "Cleaning up build directory..."
rm -rf "/workspace/builds"

echo "Setup complete."