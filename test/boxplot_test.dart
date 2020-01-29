import 'package:boxplot/src/stats.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {});

    test('Minimum', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -1];
      expect(-1, Stats.min(arr));
    });

    test('Maximum', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -1];
      expect(10, Stats.max(arr));
    });

    test('Median - Number of elements is even', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      expect(Stats.median(arr), 5.5);
    });

    test('Median - Number of elements is odd', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      expect(Stats.median(arr), 5.0);
    });

    test('q1', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
      expect(Stats.q1(arr), 3);
    });

    test('q3', () {
      List<double> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
      expect(Stats.q3(arr), 9);
    });
  });
}
