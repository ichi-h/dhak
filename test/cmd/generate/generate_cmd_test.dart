import 'package:dhak/args/separate_args.dart';
import 'package:dhak/cmd/generate/generate_cmd.dart';
import 'package:test/test.dart';
import 'package:dart_clipboard/dart_clipboard.dart';

void main() {
  group('Normal behavior', () {
    final passPhrase = 'John ate 2 peanuts and 1 banana.';

    List<String> genPasswords(List<String> args) {
      final sepArgs = SeparateArgs(args);
      final title = sepArgs.title();
      final preset = sepArgs.preset();
      final options = sepArgs.options();
      final gen =
        GenerateCmd(title, preset, options, passPhrase, './.dhakrc');

      var result = ['', ''];
      for (var i = 0; i < 2; i++) {
        gen.run();
        result[i] = Clipboard().getContents();
      }

      return result;
    }

    test('When I input the same value, will I get the same password?', () {
      final args = ['Google', 'default'];
      var result = genPasswords(args);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.');
      }
    });

    test('Dangerous password generation', () {
      final args = ['Google', 'danger', '-f'];
      var result = genPasswords(args);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.');
      }
    });

    test('Generate password with "empty" preset', () {
      final args = ['Google', 'empty', '-f'];
      var result = genPasswords(args);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.');
      }
    });
  });
}
