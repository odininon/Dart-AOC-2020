import 'package:aoc_2020/day.dart';
import 'package:aoc_2020/day_16.dart';
import 'package:test/test.dart';

void main() {
  late Day day;

  setUp(() {
    var fields = <TicketField>[
      TicketField('class', [
        ValueRange(1, 3),
        ValueRange(5, 7),
      ]),
      TicketField('row', [
        ValueRange(6, 11),
        ValueRange(33, 44),
      ]),
      TicketField('seat', [
        ValueRange(13, 40),
        ValueRange(45, 50),
      ])
    ];

    var tickets = <Ticket>[
      Ticket([7, 3, 47]),
      Ticket([40, 4, 50]),
      Ticket([55, 2, 20]),
      Ticket([38, 6, 12]),
    ];

    var ourTicket = Ticket([]);

    day = Day16(fields, tickets, ourTicket);
  });

  test('part 1', () {
    expect(day.part1(), 71);
  });

  test('part 2', () {
    // expect(day.part2(), 241861950);
  });
}
