# Dart Loop Benchmark

A simple Dart app to benchmark the relative performance of iterating through a
loop with `.forEach` versus using a `for (... in ...)` loop.

## Usage

You can execute the `test.sh` script, which will run `main.dart` both as JIT
from source and then as an AOT-compiled application.

```
$ ./test.sh
Testing with JIT from source...
forEach duration: 0:00:04.655967
for loop duration: 0:00:00.178140
The forEach took 26.136561131694172 times longer.

Cleaning previous AOT build...

Compiling AOT app...
Generated: /home/chris/git/tmp/dart-loop-benchmark/main_aot

Testing with AOT app...
forEach duration: 0:00:05.368977
for loop duration: 0:00:01.431956
The forEach took 3.749400819578255 times longer.
```
