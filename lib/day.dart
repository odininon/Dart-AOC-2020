import 'dart:convert';
import 'dart:io';

abstract class Day {
  int day;
  Day(this.day);

  int part1();
  int part2();

  Future<Day> initialize();

  Stream<String> readFile() {
    return utf8.decoder
        .bind(File('./inputs/day_$day.txt').openRead())
        .transform(const LineSplitter());
  }

  void printSolution() {
    print('Day $day - Part 1 - ${part1()}');
    print('Day $day - Part 2 - ${part2()}');
  }
}
