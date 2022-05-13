import 'package:aoc_2020/day_1.dart';
import 'package:test/test.dart';

void main() {
  late Day1 day1;

  setUp(() {
    day1 = Day1(<int>[
      1721,
      979,
      366,
      299,
      675,
      1456,
    ]);
  });

  test('part 1', () {
    expect(day1.part1(), 514579);
  });

  test('part 2', () {
    expect(day1.part2(), 241861950);
  });
}
