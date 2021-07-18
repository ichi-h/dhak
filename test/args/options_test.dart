import 'package:dhak/args/options.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  group('When option is empty ', () {
    var options = Options(['']);

    test('haveForce() is false', () {
      var result = options.haveForce();
      expect(result, isFalse);
    });

    test('haveDisplay() is false', () {
      var result = options.haveDisplay();
      expect(result, isFalse);
    });
  });

  group('When option is not empty ', () {
    var options =
        Options(['-f', '--display', '--len=20', '--algo=2b', '--cost=10']);

    test('haveForce() is true', () {
      expect(options.haveForce(), isTrue);
    });

    test('haveDisplay() is true', () {
      expect(options.haveDisplay(), isTrue);
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

    test('passLength() is 5 by -f', () {
      options =  Options(['-f', '--len=5']);
      var force = options.haveForce();
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
