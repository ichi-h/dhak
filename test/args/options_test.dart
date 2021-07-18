import 'package:dhak/args/options.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  group('When option is empty', () {
    test('There is no option', () {
      var options = Options(['']);

      List<bool> result = [];
      for (var target in OptionTarget.values) {
        result.add(options.exist(target));
      }

      var expected = [false, false, false, false, false, false];
      expect(result, equals(expected));
    });
  });

  group('When option is not empty', () {
    var options =
        Options(['-f', '--display', '--len=20', '--sym=#%`r^', '--algo=2b', '--cost=10']);

    test('There are all options', () {
      List<bool> result = [];
      for (var target in OptionTarget.values) {
        result.add(options.exist(target));
      }

      var expected = [true, true, true, true, true, true];
      expect(result, equals(expected));
    });

    test('algorithm() is "2b"', () {
      expect(options.algorithm().value(), equals('2b'));
    });

    test('cost() is "10"', () {
      expect(options.cost().value(), equals('10'));
    });

    test('passLength() is 20', () {
      expect(options.passLength().value(), equals(20));
    });

    test("symbols() is ['#', '%', '`', '^']", () {
      expect(options.symbols().value(), equals(['#', '%', '`', '^']));
    });

    test('passLength() is 5 by -f', () {
      options =  Options(['-f', '--len=5']);
      var force = options.exist(OptionTarget.force);
      expect(options.passLength().value(force), equals(5));
    });
  });

  group('Abnormal behavior', () {
    var options = Options(['--len=', '--cost=']);

    test('When passLength() is invalid', () {
      var result;
      try {
        result = options.passLength().value();
      } on DhakRuntimeException {
        return;
      }

      fail('The invalid value "$result" passes the test.');
    });

    test('When cost() is invalid', () {
      var result;
      try {
        result = options.cost().value();
      } on DhakRuntimeException {
        return;
      }

      fail('The invalid value "$result" passes the test.');
    });
  });
}
