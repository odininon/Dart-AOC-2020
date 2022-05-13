import 'day.dart';

class Day1 extends Day {
  List<int> _expenses;

  Day1([this._expenses = const []]) : super(1);

  @override
  Future<Day> initialize() async {
    _expenses = [];

    final lines = super.readFile();

    await for (final line in lines) {
      _expenses.add(int.parse(line));
    }

    return this;
  }

  @override
  int part1() {
    for (var expense1 in _expenses) {
      for (var expense2 in _expenses) {
        if (expense1 + expense2 == 2020) {
          return expense1 * expense2;
        }
      }
    }

    return -1;
  }

  @override
  int part2() {
    for (var expense1 in _expenses) {
      for (var expense2 in _expenses) {
        for (var expense3 in _expenses) {
          if (expense1 + expense2 + expense3 == 2020) {
            return expense1 * expense2 * expense3;
          }
        }
      }
    }

    return -1;
  }
}
