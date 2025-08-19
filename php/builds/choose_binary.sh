#!/bin/sh

# Current PHP Version in Built 
echo "Base PHP version ${PHP_VERSION}"

# A single string variable with a space-separated list of binaries.
AVAILABLE_BINARIES="php-8.4-aarch64 php-8.4-amd64"

# Get the current machine's architecture.
CURRENT_ARCH=$(uname -m | tr '[:upper:]' '[:lower:]')

echo "Detected architecture: ${CURRENT_ARCH}"

CORRECT_BINARY=""

# Loop through the string, treating each word as a binary.
for BINARY in ${AVAILABLE_BINARIES}; do
    case "$BINARY" in
    *"-${CURRENT_ARCH}") 
        echo "Found matching binary: ${BINARY}"
        CORRECT_BINARY="${BINARY}"
        break
        ;; 
    esac
done

if [ -z "${CORRECT_BINARY}" ]; then
    echo "Error: No matching binary found for architecture '${CURRENT_ARCH}'."
    exit 1
fi

echo "Copying ${CORRECT_BINARY} to /workspace/bin/php..."
mkdir -p /workspace/bin
cp /workspace/builds/"${CORRECT_BINARY}" /workspace/bin/php

echo "Make ${CORRECT_BINARY} executable"
chmod +x /workspace/bin/php

echo "Cleaning up build directory..."
rm -rf /workspace/builds

echo "Setup complete."