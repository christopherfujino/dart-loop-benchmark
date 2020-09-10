#!/usr/bin/env bash

echo -e 'Testing with JIT from source...\n'
dart ./main.dart
echo

echo -e 'Cleaning previous AOT build...\n'
rm --force ./main_aot
echo

echo -e 'Compiling AOT app...\n'
dart2native ./main.dart -o main_aot
echo

echo -e 'Testing with AOT app...\n'
./main_aot
echo

echo -e 'Cleaning previous dart2js build...\n'
rm --force ./out.js*
echo

echo -e 'Compiling dart2js app...\n'
dart2js ./main.dart
echo

echo -e 'Testing with node.js...\n'
node ./out.js
