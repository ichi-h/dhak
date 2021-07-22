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
        'preset': '',
        'options': ['']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub", "sample"]', () {
      args = ['GitHub', 'sample'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'sample',
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
        'preset': '',
        'options': ['-d']
      };
      expect(actual, equals(expected));
    });

    test('Args: ["GitHub", "sample", "-s", "--length=12"]', () {
      args = ['GitHub', 'sample', '-s', '--length=12'];
      sepArgs = new SeparateArgs(args);
      final actual = {
        'title': sepArgs.title(),
        'preset': sepArgs.preset(),
        'options': sepArgs.options()
      };
      final expected = {
        'title': 'GitHub',
        'preset': 'sample',
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

    test('Args: ["GitHub", "-s", "sample"]', () {
      args = ['GitHub', '-s', 'sample'];
      sepArgs = new SeparateArgs(args);
      try {
        check(sepArgs);
      } on DhakArgsException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "sample", "foo"]', () {
      args = ['GitHub', 'sample', 'foo'];
      sepArgs = new SeparateArgs(args);
      try {
        check(sepArgs);
      } on DhakArgsException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "sample", "foo", "-s"]', () {
      args = ['GitHub', 'sample', 'foo', '-s'];
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
