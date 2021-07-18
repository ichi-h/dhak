import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dart_clipboard/dart_clipboard.dart';
import 'package:dhak/args/options.dart';
import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/cmd/generate/password_gen.dart';
import 'package:dhak/cmd/generate/password_status.dart';
import 'package:dhak/config/config.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:dhak/util/hidden_input.dart';

class GenerateCmd extends Cmd {
  late final String title;
  late final String presetName;
  late final Options options;
  late String passPhrase;
  late String path;

  GenerateCmd(String title, String presetName, List<String> optionList,
      [String passPhrase = '', String path = '']) {
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
      throw DhakRuntimeException(
          'Runtime error: The passphrase you entered was not secure. '
          'At least, a passphrase must have length of 8 or more and contain one lower-case, upper-case and number at least.');
    }

    // The countermeasure for the total length with the passphrase and the title
    // which exceeds 72.
    // The hash length of SHA512 in bytes is 64, so it will never exceed the Bcrypt
    // byte limit.
    final bytes = utf8.encode(this.passPhrase + this.title);
    final hash = sha512.convert(bytes).bytes;
    final target = String.fromCharCodes(hash);

    final config = Config(this.path);
    final preset = config.getPreset(this.presetName);

    var passGen = PasswordGen(target, preset, this.options);
    var password = passGen.getPassword();

    final clipboard = Clipboard();
    clipboard.setContents(password);

    print('Password was copied to clipboard!');
    if (this.options.exist(OptionTarget.display)) {
      print('Password: $password');
    }
  }
}
