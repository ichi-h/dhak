import 'package:dhak/args/options.dart';
import 'package:dhak/cmd/generate/password_gen.dart';
import 'package:dhak/config/config.dart';
import 'package:dhak/config/preset.dart';
import 'package:test/test.dart';

List<String> genPasswords(String target, Preset preset, Options options) {
  var passwords = ['', ''];
  for (var i = 0; i < 2; i++) {
    var passGen = PasswordGen(target, preset, options);
    passwords[i] = passGen.getPassword();
  }
  return passwords;
}

void main() {
  group('Normal behavior', () {
    final target = 'fooGoogle';
    final config = Config('./.dhakrc');
    var preset;

    test('When there is no option', () {
      var options = Options(['']);
      preset = config.getPreset('default');
      var result = genPasswords(target, preset, options);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });

    test('Dangerous password generation', () {
      var options = Options(['']);
      preset = config.getPreset('danger');
      var result = genPasswords(target, preset, options);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });

    test('Generate password with "empty" preset', () {
      var options = Options(['']);
      preset = config.getPreset('empty');
      var result = genPasswords(target, preset, options);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });

    test('Generate password by option settings', () {
      final args = [
        'Google',
        '--len=5',
        '--sym=\$%p^-@',
        '--algo=2',
        '--cost=4',
        '-f'
      ];
      var options = Options(args);
      preset = config.getPreset('empty');
      var result = genPasswords(target, preset, options);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });
  });
}
