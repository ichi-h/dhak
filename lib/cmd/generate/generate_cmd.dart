import 'package:dart_clipboard/dart_clipboard.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:dhak/cmd/generate/password_status.dart';
import 'package:dhak/config/config.dart';
import 'package:dhak/config/preset.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:dhak/util/hidden_input.dart';

class GenerateCmd extends Cmd {
  final String title;
  final String presetName;
  final String option;
  String passPhrase;
  String path;

  GenerateCmd(this.title, this.presetName, this.option, [this.passPhrase = '', this.path = '~/.dhakrc']);

  @override
  void run() {
    if (this.passPhrase == '') {
      this.passPhrase = HiddenInput.readPassword('Passphrase: ');
    }

    PasswordStatus status;

    status = PasswordStatus(passPhrase);
    if (!status.isSecure()) {
      print('WARNING: The passphrase you entered was not secure.');
      print(
          'A passphrase should have length of 8 or more and contain at least one lower-case, upper-case and number.\n');
    }

    final target = this.passPhrase + this.title;
    if (70 < target.length) {
      throw DhakRuntimeException(
          'Runtime error: dhak does not allow a passphrase and title with the total length of more than 70.');
    }

    final config = Config(this.path);
    final preset = Preset(this.presetName, config.doc());
    if (preset.salt() == '') {
      preset.setSalt(DBCrypt().gensalt());
      config.setPresets(preset);
      config.write();
      print('Override the salt value of the preset "${this.presetName}".');
    }

    var password = this._genPassword(target, config, preset);
    status = PasswordStatus(password);
    var i = 0;
    while (!status.isSecure()) {
      password = this._genPassword('$target$i', config, preset);
      i++;
    }

    final clipboard = Clipboard();
    clipboard.setContents(password);

    print('Password was copied to clipboard!');
    if (this.option.contains('s') || this.option.contains('show')) {
      print('Password: $password');
    }
  }

  String _genPassword(String target, Config config, Preset preset) {
    final bcrypted = DBCrypt().hashpw(target, preset.salt());
    var reversed = '';
    for (var i = bcrypted.length - 1; 0 < i; i--) {
      reversed += bcrypted[i];
    }

    var password = reversed.substring(0, preset.passLength());

    final operator = PasswordOperator(password);
    if (preset.symbols().length != 0) {
      password = operator.replaceAtRandomWith(preset.symbols());
    } else {
      password = operator.replaceSymbols();
    }

    return password;
  }
}
