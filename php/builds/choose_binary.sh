#!/bin/sh

# This script is designed to be compatible with POSIX-compliant shells like Ash (used in Alpine).

# Get the current machine's architecture.
CURRENT_ARCH=$(uname -m)
PHP_VERSION_CLEAN=$(echo "$PHP" | tr -d '.')

# Standardize architecture names to a format we can match.PO
case "$CURRENT_ARCH" in
x86_64) 
    CURRENT_ARCH="x86_64"
    CORRECT_BINARY="php-static-cli-${PHP_VERSION_CLEAN}-amd64"
    ;; 
aarch64) 
    CURRENT_ARCH="aarch64"
    CORRECT_BINARY="php-static-cli-${PHP_VERSION_CLEAN}-arm64"
    ;; 
*) 
    echo "Error: Unsupported architecture '${CURRENT_ARCH}'." >&2
    exit 1
    ;; 
esac

echo "Detected architecture: ${CURRENT_ARCH}"

# Create the destination directory if it doesn't exist
mkdir -p /workspace/bin

# The original script attempts to copy from /workspace/builds. Assuming the unzipped binary is already there.
cp "/workspace/builds/${CORRECT_BINARY}" "/workspace/bin/php"

# Make the copied binary executable.
echo "Making binary executable..."
chmod +x "/workspace/bin/php"

# Clean up the build directory.
echo "Cleaning up build directory..."
rm -rf "/workspace/builds"

echo "Setup complete."