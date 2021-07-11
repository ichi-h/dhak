import 'package:test/test.dart';
import 'package:dhak/args/syntax_checker.dart' show SyntaxChecker;
import 'package:dhak/dhak_exception.dart' show DhakSyntaxException;

void main() {
  group('Normal behavior', () {
    var args;
    SyntaxChecker checker;

    test('Args: ["-h"]', () {
      args = ['-h'];
      checker = new SyntaxChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub"]', () {
      args = ['GitHub'];
      checker = new SyntaxChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "default"]', () {
      args = ['GitHub', 'default'];
      checker = new SyntaxChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "-s"]', () {
      args = ['GitHub', '-s'];
      checker = new SyntaxChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });

    test('Args: ["GitHub", "default", "-s"]', () {
      args = ['GitHub', 'default', '-s'];
      checker = new SyntaxChecker(args);
      final result = checker.checkedArgs();
      expect(result, equals(args));
    });
  });

  group('Abnormal behavior', () {
    var args;
    SyntaxChecker checker;

    test('Args: ["-s", "GitHub"]', () {
      args = ['-s', 'GitHub'];
      checker = new SyntaxChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["-s", "GitHub", "default"]', () {
      args = ['-s', 'GitHub', 'default'];
      checker = new SyntaxChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "-s", "default"]', () {
      args = ['GitHub', '-s', 'default'];
      checker = new SyntaxChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "default", "foo"]', () {
      args = ['GitHub', 'default', 'foo'];
      checker = new SyntaxChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException{
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });

    test('Args: ["GitHub", "-s", "default", "foo"]', () {
      args = ['GitHub', '-s', 'default', 'foo'];
      checker = new SyntaxChecker(args);
      try {
        checker.check();
      } on DhakSyntaxException {
        return;
      }
      fail('The command-line with syntax error passes the test.');
    });
  });
}