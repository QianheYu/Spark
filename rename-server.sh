#!/bin/sh

rm -f ./releases/*darwin*
rm -f ./releases/*windows*
ARCH=$(uname -m)
echo "Current architecture: ${ARCH}"

if [ "$ARCH" = "x86_64" ]; then
    echo "System architecture is 64-bit"
    mv ./releases/server_linux_amd64 ./releases/spark
elif [ "$ARCH" = "i386" ]; then
    echo "System architecture is 32-bit"
    mv ./releases/server_linux_i386 ./releases/spark
elif [ "$ARCH" = "armv7l" ] || [ "$ARCH" = "armhf" ]; then
    echo "System architecture is ARMv7"
    mv ./releases/server_linux_arm ./releases/spark
elif [ "$ARCH" = "aarch64" ]; then
    echo "System architecture is ARMv8"
    mv ./releases/server_linux_arm64 ./releases/spark
else
    echo "No driver for this architecture: ${ARCH}"
    exit 1
fi