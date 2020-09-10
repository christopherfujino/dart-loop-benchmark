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

forEach duration: 0:00:04.544207
for loop duration: 0:00:00.174925
The forEach took 26.0 times longer.

Cleaning previous AOT build...

Compiling AOT app...

Generated: /home/chris/git/tmp/dart-loop-benchmark/main_aot

Testing with AOT app...

forEach duration: 0:00:05.122525
for loop duration: 0:00:01.439499
The forEach took 3.6 times longer.

Cleaning previous dart2js build...

Compiling dart2js app...

Compiled 8,110,015 characters Dart to 107,470 characters JavaScript in 1.09 seconds

Testing with node.js...

forEach duration: 0:00:12.155000
for loop duration: 0:00:00.862000
The forEach took 14.1 times longer.
```
