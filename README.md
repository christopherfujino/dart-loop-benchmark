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

forEach duration: 0:00:00.668842
for loop duration: 0:00:00.175255
The forEach took 382% as long as for loop.

Testing from JIT snapshot...

Compiling ./main.dart to jit-snapshot file main.jit.
forEach duration: 0:00:00.579704
for loop duration: 0:00:00.174488
The forEach took 332% as long as for loop.

Testing with AOT app...

forEach duration: 0:00:00.842090
for loop duration: 0:00:00.954408
The forEach took 88% as long as for loop.

Testing with node.js...

forEach duration: 0:00:02.841000
for loop duration: 0:00:01.040000
The forEach took 273% as long as for loop.
```
