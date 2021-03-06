import 'dart:math';

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
  for (int i = 0; i < matrix.length; i++) {
  //for (List<int> row in matrix) {
    for (int j = 0; j < matrix[i].length; j++) {
    //for (int value in row) {
      sums += matrix[i][j];
    }
  }
  return sums;
}

/// Random number generator seed.
///
/// We use a constant seed so that the test is deterministic.
const SEED = 12345;

List<List<int>> generateMatrix(rand) {
  List<List<int>> matrix = <List<int>>[];
  const dimensionLimit = 20000;
  final x = rand.nextInt(dimensionLimit);
  for (int i = 0; i < x; i++) {
    final List<int> row = <int>[];
    final y = rand.nextInt(dimensionLimit);
    for (int j = 0; j < y; j++) {
      row.add(rand.nextInt(999999));
    }
    matrix.add(row);
  }
  return matrix;
}

void main() {
  Stopwatch stopwatch = Stopwatch();
  final rand = Random(SEED);

  // This takes time, but is not benchmarked
  final matrix = generateMatrix(rand);
  stopwatch.start();

  final forEachSum = forEach(matrix);
  stopwatch.stop();
  final forEachDuration = stopwatch.elapsed;

  stopwatch
    ..reset()
    ..start();
  final forLoopSum = forLoop(matrix);
  stopwatch.stop();
  final forLoopDuration = stopwatch.elapsed;

  if (forEachSum != forLoopSum) {
    throw Exception('The two implementations did not return the same result!');
  }

  print('forEach duration: ${forEachDuration}');
  print('for loop duration: ${forLoopDuration}');
  print(
      'The forEach took ${(forEachDuration.inMicroseconds / forLoopDuration.inMicroseconds * 100).toStringAsFixed(0)}% as long as '
      'for loop.\n');
}
