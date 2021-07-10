import 'package:test/test.dart';
import 'package:dhak/args_checker.dart' show ArgsChecker;
import 'package:dhak/dhak_exception.dart' show DhakSyntaxException;

void main() {
  group('Normal behavior', () {
    var args;
    ArgsChecker checker;

    test('Args: ["-h"]', () {
      args = ['-h'];
      checker = new ArgsChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub"]', () {
      args = ['GitHub'];
      checker = new ArgsChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "default"]', () {
      args = ['GitHub', 'default'];
      checker = new ArgsChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "-s"]', () {
      args = ['GitHub', '-s'];
      checker = new ArgsChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "default", "-s"]', () {
      args = ['GitHub', 'default', '-s'];
      checker = new ArgsChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });
  });

  group('Abnormal behavior', () {
    var args;
    ArgsChecker checker;

    test('Args: ["-s", "GitHub"]', () {
      args = ['-s', 'GitHub'];
      checker = new ArgsChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["-s", "GitHub", "default"]', () {
      args = ['-s', 'GitHub', 'default'];
      checker = new ArgsChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "-s", "default"]', () {
      args = ['GitHub', '-s', 'default'];
      checker = new ArgsChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });
  });
}