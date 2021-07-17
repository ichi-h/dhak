import 'package:dhak/args/options.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  group('When option is empty ', () {
    var options = Options(['']);

    test('haveForce() is false', () {
      expect(options.haveForce(), isFalse);
    });

    test('haveDisplay() is false', () {
      expect(options.haveDisplay(), isFalse);
    });

    test('passLength() is 20', () {
      expect(options.passLength(20), equals(20));
    });

    test('algorithm() is "2b"', () {
      expect(options.algorithm('2b'), equals('2b'));
    });

    test('cost() is "10"', () {
      expect(options.cost('10'), equals('10'));
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
      expect(options.algorithm('2'), equals('2b'));
    });

    test('cost() is "10"', () {
      expect(options.cost('1'), equals('10'));
    });

    test('passLength() is 20', () {
      expect(options.passLength(0), equals(20));
    });

    test('passLength() is 5 by -f', () {
      options =  Options(['-f', '--len=5']);
      expect(options.passLength(0), equals(5));
    });
  });

  group('Abnormal behavior', () {
    var options = Options(['--len=', '--cost=']);

    test('When passLength() is invalid', () {
      var result;
      try {
        result = options.passLength(20);
      } on DhakRuntimeException {
        return;
      }

      fail('The invalid value "$result" passes the test.');
    });

    test('When cost() is invalid', () {
      var result;
      try {
        result = options.cost('10');
      } on DhakRuntimeException {
        return;
      }

      fail('The invalid value "$result" passes the test.');
    });
  });
}
