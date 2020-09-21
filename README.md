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

forEach duration: 0:00:00.687409
for loop duration: 0:00:00.196123
The forEach took 350% as long as for loop.

Testing from JIT snapshot...

Compiling ./main.dart to jit-snapshot file main.jit.
forEach duration: 0:00:00.618646
for loop duration: 0:00:00.196801
The forEach took 314% as long as for loop.

Testing with AOT app...

forEach duration: 0:00:00.955987
for loop duration: 0:00:00.954359
The forEach took 100% as long as for loop.

Testing with node.js...

forEach duration: 0:00:03.275000
for loop duration: 0:00:01.559000
The forEach took 210% as long as for loop.
```
