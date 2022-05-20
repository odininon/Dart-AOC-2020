import 'package:aoc_2020/day.dart';

class Observation {
  List<String> inputs = [];
  List<String> outputs = [];

  Observation(this.inputs, this.outputs);

  static Observation from(String line) {
    final split = line.split(' | ');

    final inputs = split[0].split(' ');
    final outputs = split[1].split(' ');
    return Observation(inputs, outputs);
  }

  int countSimple() {
    int count = 0;

    for (var output in outputs) {
      if (output.length == 2 ||
          output.length == 4 ||
          output.length == 3 ||
          output.length == 7) {
        count += 1;
      }
    }

    return count;
  }
}

class Connection {
  String wiring;
  String signal;

  Connection(this.wiring, this.signal);

  @override
  String toString() {
    return 'Connection{ wiring: ${wiring.toString()}, signal: ${signal.toString()}}';
  }
}

class SegmentDisplay {
  String wiring;

  Map<String, int> connections = {
    '111-111': 0,
    '--1--1-': 1,
    '1-111-1': 2,
    '1-11-11': 3,
    '-111-1-': 4,
    '11-1-11': 5,
    '11-1111': 6,
    '1-1--1-': 7,
    '1111111': 8,
    '1111-11': 9
  };

  SegmentDisplay([this.wiring = "-------"]);

  void displayNumber() {
    print(" ${wiring[0] * 4} ");
    print("${wiring[1]}    ${wiring[2]}");
    print("${wiring[1]}    ${wiring[2]}");
    print(" ${wiring[3] * 4} ");
    print("${wiring[4]}    ${wiring[5]}");
    print("${wiring[4]}    ${wiring[5]}");
    print(" ${wiring[6] * 4} ");
  }

  int decode(String s) {
    List<String> key = '-------'.split('');

    for (var chara in s.split('')) {
      for (var i = 0; i < wiring.length; i++) {
        if (wiring[i] == chara) {
          key[i] = '1';
        }
      }
    }
    return connections[key.join('')]!;
  }
}

class Day8 extends Day {
  List<Observation> _signals;

  Day8([this._signals = const []]) : super(8);

  @override
  Future<Day> initialize() async {
    _signals = [];
    final lines = super.readFile();

    await for (final line in lines) {
      _signals.add(Observation.from(line));
    }

    return this;
  }

  @override
  int part1() {
    int count = 0;

    for (var signal in _signals) {
      count += signal.countSimple();
    }

    return count;
  }

  @override
  int part2() {
    int sum = 0;
    for (var signal in _signals) {
      sum += getDisplay(signal);
    }

    return sum;
  }

  int getDisplay(Observation observation) {
    List<Set<String>> possiblies = [];

    for (var i = 0; i < 7; i++) {
      possiblies.add({});
    }

    List<Connection> connections = [];

    for (var input in observation.inputs) {
      switch (input.length) {
        case 7:
          connections.add(Connection("1111111", input));
          break;
        case 3:
          connections.add(Connection("1-1--1-", input));
          break;
        case 2:
          connections.add(Connection("--1--1-", input));
          break;
        case 4:
          connections.add(Connection("-111-1-", input));
          break;
        case 6:
          connections.add(Connection('11***11', input));
          break;
        default:
      }
    }

    for (var connection in connections) {
      for (var i = 0; i < connection.wiring.length; i++) {
        final t = connection.wiring[i];

        if (t == '-') {
          possiblies[i].removeWhere(
            (element) => connection.signal.split('').contains(element),
          );
        }

        if (t == '1') {
          var g = connection.signal.split('');

          if (possiblies[i].isEmpty) {
            possiblies[i].addAll(g);
          } else {
            possiblies[i].removeWhere((element) => !g.contains(element));
          }
        }
      }
    }

    removeOverlaps(possiblies);

    String wiring = '';

    for (var possiblity in possiblies) {
      wiring += possiblity.first;
    }

    final display = SegmentDisplay(wiring);

    var displayText = '';

    for (var output in observation.outputs) {
      displayText += '${display.decode(output)}';
    }

    var displayNumber = int.parse(displayText);
    return displayNumber;
  }

  void removeOverlaps(List<Set<String>> possiblies) {
    for (var i = 0; i < possiblies.length; i++) {
      for (var k = 0; k < possiblies.length; k++) {
        if (i == k) continue;

        if (possiblies[i].length != 1 && possiblies[k].length != 1) continue;

        if (possiblies[i].length == 1) {
          possiblies[k].removeWhere(
            (element) => possiblies[i].contains(element),
          );
        } else {
          possiblies[i].removeWhere(
            (element) => possiblies[k].contains(element),
          );
        }
      }
    }
  }
}
