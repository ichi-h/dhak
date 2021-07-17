import 'package:test/test.dart';
import 'package:dhak/args/separate_args.dart';
import 'package:dhak/util/dhak_exception.dart' show DhakArgsException;

void main() {
  group('Normal behavior', () {
    var args;
    SeparateArgs sepArgs;

    test('Args: ["-h"]', () {
      args = ['-h'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': '',
        'preset': '',
        'options': ['-h']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub"]', () {
      args = ['GitHub'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'default',
        'options': ['']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub", "default"]', () {
      args = ['GitHub', 'default'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'default',
        'options': ['']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub", "-d"]', () {
      args = ['GitHub', '-d'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'default',
        'options': ['-d']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub", "default", "-s", "--length=12"]', () {
      args = ['GitHub', 'default', '-s', '--length=12'];
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'default',
        'options': ['-s', '--length=12']
      };
      expect(actual, equals(expected));
    });
  });

  group('Abnormal behavior', () {
    var args;
    SeparateArgs sepArgs;

    void check(SeparateArgs sepArgs) {
      sepArgs.title();
      sepArgs.preset();
      sepArgs.options();
    }

    test('Args: ["GitHub", "-s", "default"]', () {
      args = ['GitHub', '-s', 'default'];
      sepArgs = new SeparateArgs(args);
      try {
        check(sepArgs);
      } on DhakArgsException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "default", "foo"]', () {
      args = ['GitHub', 'default', 'foo'];
      sepArgs = new SeparateArgs(args);
      try {
        check(sepArgs);
      } on DhakArgsException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "default", "foo", "-s"]', () {
      args = ['GitHub', 'default', 'foo', '-s'];
      sepArgs = new SeparateArgs(args);
      try {
        check(sepArgs);
      } on DhakArgsException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });
  });
}
