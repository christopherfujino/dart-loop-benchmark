#!/usr/bin/env bash

set -euo pipefail

echo -e 'Testing with JIT from source...\n'
dart ./main.dart

# Clean previous JIT snapshot
rm --force ./main.jit

echo -e 'Testing from JIT snapshot...\n'
dart compile jit-snapshot ./main.dart -o main.jit

# Clean previous AOT build
rm --force ./main.aot

# Compile fresh AOT build
dart2native ./main.dart -o main.aot > /dev/null

echo -e 'Testing with AOT app...\n'
./main.aot

# Clean previous js build
rm --force ./main.js*

# Compile JS app
dart compile js ./main.dart -o main.js > /dev/null

echo -e 'Testing with node.js...\n'
node ./main.js
