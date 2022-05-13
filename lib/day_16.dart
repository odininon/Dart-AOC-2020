import 'dart:convert';
import 'dart:io';

import 'day.dart';

class ValueRange {
  int bottom;
  int top;

  ValueRange(this.bottom, this.top);

  bool isValid(int value) {
    return value >= bottom && value <= top;
  }

  static ValueRange fromString(line) {
    var regExp = RegExp(r"^(\d+)-(\d+)$");

    var match = regExp.firstMatch(line)!;
    return ValueRange(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
    );
  }

  @override
  String toString() {
    return 'ValueRange{ bottom: $bottom, top: $top }';
  }
}

class TicketField {
  String name;
  List<ValueRange> ranges;

  TicketField(this.name, this.ranges);

  bool isValid(int value) {
    return ranges.fold(false,
        (previousValue, element) => previousValue || element.isValid(value));
  }

  static TicketField fromString(line) {
    var regExp = RegExp(r"^(.*):\s(.*)\sor\s(.*)$");

    var match = regExp.firstMatch(line)!;

    return TicketField(match.group(1)!, [
      ValueRange.fromString(match.group(2)!),
      ValueRange.fromString(match.group(3)!),
    ]);
  }

  @override
  String toString() {
    return 'TicketField{ name: $name, ranges: ${ranges.toString()} }';
  }
}

class Ticket {
  List<int> values;

  Ticket(this.values);

  static Ticket fromString(String line) {
    return Ticket(line.split(',').map((e) => int.parse(e)).toList());
  }

  @override
  String toString() {
    return 'Ticket{ Values: ${values.toString()} }';
  }
}

enum FileSection { fields, ourTicket, nearbyTickets }

class Day16 extends Day {
  List<TicketField> fields = [];
  List<Ticket> tickets = [];

  Day16([this.fields = const [], this.tickets = const []]) : super(16);

  @override
  Future<Day16> initialize() async {
    var lines = utf8.decoder
        .bind(File('./inputs/day_16.txt').openRead())
        .transform(LineSplitter());

    var currentFileSection = FileSection.fields;

    fields = [];
    tickets = [];

    await for (var line in lines) {
      switch (currentFileSection) {
        case FileSection.fields:
          if (line.isEmpty) {
            currentFileSection = FileSection.ourTicket;

            continue;
          }
          fields.add(TicketField.fromString(line));
          break;
        case FileSection.ourTicket:
          currentFileSection = FileSection.nearbyTickets;

          continue;
        case FileSection.nearbyTickets:
          if (line.isEmpty) {
            break;
          }
          try {
            tickets.add(Ticket.fromString(line));
          } catch (_) {
            continue;
          }
          break;
      }
    }

    return this;
  }

  @override
  int part1() {
    var sum = 0;

    for (var ticket in tickets) {
      for (var value in ticket.values) {
        if (!fields.fold(
            false,
            (previousValue, element) =>
                previousValue || element.isValid(value))) {
          sum += value;
        }
      }
    }

    return sum;
  }

  @override
  int part2() {
    return -1;
  }
}
