import 'package:test/test.dart';
import 'package:dhak/separate_args.dart' show SeparateArgs;

void main() {
  group('Normal behavior', () {
    group('When the command-line arguments exist', () {
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

    group('When the command-line arguments are empty', () {
      final args = [''];
      final sepArgs = new SeparateArgs(args);

      test('SeparateArgs.title() is ""', () {
        expect(sepArgs.title(), equals(''));
      });

      test('SeparateArgs.preset() is ""', () {
        expect(sepArgs.preset(), equals(''));
      });

      test('SeparateArgs.options() is ""', () {
        expect(sepArgs.option(), equals(''));
      });
    });
  });

  // group('Abnormal behavior', body);
}