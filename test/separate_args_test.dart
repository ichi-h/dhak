import 'package:test/test.dart';
import 'package:dhak/separate_args.dart' show SeparateArgs;

void main() {
  group('Normal behavior', () {
    group('Args: ["GitHub", "-s"]', () {
      final args = ['GitHub', '-s'];
      final sepArgs = new SeparateArgs(args);

      test('SeparateArgs.title() is "GitHub"', () {
        expect(sepArgs.title(), equals('GitHub'));
      });

      test('SeparateArgs.preset() is "default"', () {
        expect(sepArgs.preset(), equals('default'));
      });

      test('SeparateArgs.options() is "-s"', () {
        expect(sepArgs.option(), equals('-s'));
      });
    });

    group('Args: ["--help"]', () {
      final args = ['--help'];
      final sepArgs = new SeparateArgs(args);

      test('SeparateArgs.title() is ""', () {
        expect(sepArgs.title(), equals(''));
      });

      test('SeparateArgs.preset() is ""', () {
        expect(sepArgs.preset(), equals(''));
      });

      test('SeparateArgs.options() is "--help"', () {
        expect(sepArgs.option(), equals('--help'));
      });
    });
  });

  // group('Abnormal behavior', body);
}