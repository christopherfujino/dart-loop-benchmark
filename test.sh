#!/usr/bin/env bash

echo 'Testing with JIT from source...'
dart ./main.dart
echo

echo 'Cleaning previous AOT build...'
rm --force ./main_aot
echo

echo 'Compiling AOT app...'
dart2native ./main.dart -o main_aot
echo

echo 'Testing with AOT app...'
./main_aot
