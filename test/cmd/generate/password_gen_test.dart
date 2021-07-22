import 'package:dhak/crypto/gen_salt.dart';
import 'package:dhak/settings/options.dart';
import 'package:dhak/cmd/generate/password_gen.dart';
import 'package:dhak/settings/config.dart';
import 'package:dhak/settings/settings.dart';
import 'package:test/test.dart';

List<String> genPasswords(
    String target, Settings settings, bool force) {
  var len = settings.passLength().value(force);
  var sym = settings.symbols().value();
  var algo = settings.algorithm().value();
  var cost = settings.cost().value();
  var salt = GenSalt.generateSaltFromRnd(target.hashCode, algo, cost);

  var passwords = ['', ''];
  for (var i = 0; i < 2; i++) {
    var passGen = PasswordGen(target, len, sym, salt, force);
    passwords[i] = passGen.getPassword();
  }
  return passwords;
}

void main() {
  group('Normal behavior', () {
    final target = 'fooGoogle';
    final config = Config('./.dhakrc');
    Settings settings;
    bool force;

    test('When option and preset do not exist', () {
      final options = Options(['']);
      settings = options;
      force = options.exist(OptionTarget.force);

      var result = genPasswords(target, settings, force);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });

    test('Dangerous password generation', () {
      final options = Options(['--force']);
      settings = config.getPreset('danger');
      force = options.exist(OptionTarget.force);

      var result = genPasswords(target, settings, force);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });

    test('Generate password with "empty" preset', () {
      var options = Options(['']);
      settings = config.getPreset('empty');
      force = options.exist(OptionTarget.force);
      var result = genPasswords(target, settings, force);
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
      settings = config.getPreset('empty');
      force = options.exist(OptionTarget.force);
      var result = genPasswords(target, settings, force);
      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.\n'
            'result[0]: ${result[0]}\n'
            'result[1]: ${result[1]}');
      }
    });
  });
}
