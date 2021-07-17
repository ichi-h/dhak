import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dart_clipboard/dart_clipboard.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:dhak/args/options.dart';
import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:dhak/cmd/generate/password_status.dart';
import 'package:dhak/config/config.dart';
import 'package:dhak/config/preset.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:dhak/util/hidden_input.dart';

class GenerateCmd extends Cmd {
  late final String title;
  late final String presetName;
  late final Options options;
  late String passPhrase;
  late String path;

  GenerateCmd(String title, String presetName, List<String> optionList, [String passPhrase = '', String path = '']) {
    this.title = title;
    this.presetName = presetName;
    this.options = Options(optionList);
    this.passPhrase = passPhrase;

    if (path == '') {
      Map<String, String> env = Platform.environment;

      if (Platform.isWindows) {
        this.path = '${env['UserProfile']!}/.dhakrc';
      } else if (Platform.isMacOS || Platform.isLinux) {
        this.path = '${env['HOME']!}/.dhakrc';
      } else {
        throw DhakRuntimeException(
            'Platform error: "${Platform.operatingSystem}" is not supported.');
      }
    } else {
      this.path = path;
    }
  }

  @override
  void run() {
    if (this.passPhrase == '') {
      this.passPhrase = HiddenInput.readPassword('Passphrase: ');
    }

    PasswordStatus status;

    status = PasswordStatus(passPhrase);
    if (!status.isSecure()) {
      print('WARNING: The passphrase you entered was not secure. '
          'A passphrase should have length of 8 or more and contain at least one lower-case, upper-case and number.\n');
    }

    // The countermeasure for the total length with the passphrase and the title
    // which exceeds 72.
    // The hash length of SHA512 in bytes is 64, so it will never exceed the Bcrypt
    // byte limit.
    final bytes = utf8.encode(this.passPhrase + this.title);
    final hash = sha512.convert(bytes).bytes;
    final target = String.fromCharCodes(hash);

    final config = Config(this.path);
    final preset = config.getPreset(this.presetName, target.hashCode);

    var password = this._genPassword(target, preset);
    status = PasswordStatus(password);
    final rnd = Random(password.hashCode);
    while (!status.isSecure(this.options.haveForce())) {
      var num = rnd.nextInt(100);
      password = this._genPassword('$num$target', preset);
      status = PasswordStatus(password);
    }

    final clipboard = Clipboard();
    clipboard.setContents(password);

    print('Password was copied to clipboard!');
    if (this.options.haveDisplay()) {
      print('Password: $password');
    }
  }

  String _genPassword(String target, Preset preset) {
    final defLen = preset.passLength();
    final len = this.options.passLength(defLen);

    final defSalt = preset.salt().split('\$');
    final algo = this.options.algorithm(defSalt[1]);
    final cost = this.options.cost(defSalt[2]);
    final salt = '\$$algo\$$cost\$${defSalt[3]}';

    var reversed = '';
    var encrypted = target;
    while (reversed.length < len) {
      encrypted = DBCrypt().hashpw(encrypted, salt);
      for (var i = encrypted.length - 1; 29 <= i; i--) {
        reversed += encrypted[i];
      }
    }

    final defSym = preset.symbols();
    final symbols = this.options.symbols(defSym);

    var password = reversed.substring(0, len);
    final operator = PasswordOperator(password);
    if (symbols.length != 0) {
      password = operator.replaceAtRandomWith(symbols);
    } else {
      password = operator.replaceSymbols();
    }

    return password;
  }
}
