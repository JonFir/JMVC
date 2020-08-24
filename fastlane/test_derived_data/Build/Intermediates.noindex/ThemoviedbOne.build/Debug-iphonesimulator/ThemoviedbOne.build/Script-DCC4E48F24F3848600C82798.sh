#!/bin/sh
if which swiftgen >/dev/null; then
swiftgen
else
echo "warning: SwiftGen not installed, download it from https://github.com/SwiftGen/SwiftGen"
fi

