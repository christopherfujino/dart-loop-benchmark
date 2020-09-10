# Dart Loop Benchmark

A simple Dart app to benchmark the relative performance of iterating through a
loop with `.forEach` versus using a `for (... in ...)` loop.

## Implementation

The code is essentially comparing the performance of visiting every element in a
2-dimensional matrix (a nested list of lists of integers), summing the integer
values. In an attempt to trick the compiler from over-optimizing such a trivial
application, the matrix dimensions are generated "randomly", though from a
constant seed value, so that results will be deterministic.

```dart
int forEach(List<List<int>> matrix) {
  int sums = 0;
  matrix.forEach((row) {
    row.forEach((value) {
      sums += value;
    });
  });
  return sums;
}

int forLoop(List<List<int>> matrix) {
  int sums = 0;
  for(List<int> row in matrix) {
    for (int value in row) {
      sums += value;
    }
  }
  return sums;
}
```

## Usage

You can execute the `test.sh` script, which will run `main.dart` both as JIT
from source and then as an AOT-compiled application.

The following are the results from being run on an x64 Linux system:

```
$ ./test.sh
Testing with JIT from source...

forEach duration: 0:00:00.583692
for loop duration: 0:00:00.175692
The forEach took 3.3 times longer.

Testing from JIT snapshot...

Compiling ./main.dart to jit-snapshot file main.jit.
forEach duration: 0:00:00.825281
for loop duration: 0:00:00.176557
The forEach took 4.7 times longer.

Generated: /home/chris/git/tmp/dart-loop-benchmark/main.aot
Testing with AOT app...

forEach duration: 0:00:00.719786
for loop duration: 0:00:01.391169
The forEach took 0.5 times longer.
Compiled 8,110,029 characters Dart to 107,473 characters JavaScript in 0.90 seconds
Dart file ./main.dart compiled to JavaScript: main.js
Testing with node.js...

forEach duration: 0:00:03.300000
for loop duration: 0:00:01.030000
The forEach took 3.2 times longer.
```
