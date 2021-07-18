import 'dart:math';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:dhak/args/options.dart';
import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:dhak/cmd/generate/password_status.dart';
import 'package:dhak/config/preset.dart';

class PasswordGen {
  final String _target;
  final Preset _preset;
  final Options _options;

  PasswordGen(this._target, this._preset, this._options);

  String getPassword() {
    var force = this._options.haveForce();

    var password = this._genPassword(force);
    final rnd = Random(password.hashCode);
    PasswordStatus status = PasswordStatus(password);
    while (!status.isSecure(force)) {
      var num = rnd.nextInt(100) + 1;
      password = this._genPassword(force, num);
      status = PasswordStatus(password);
    }

    return password;
  }

  String _genPassword(bool force, [int rndInt = 0]) {
    var len = this._preset.passLength().value(force);
    if (this._options.exist(OptionTarget.len)) {
      len = this._options.passLength().value(force);
    }

    var algo = this._preset.algorithm().value();
    var cost = this._preset.cost().value();
    if (this._options.exist(OptionTarget.algo)) {
      algo = this._options.algorithm().value();
    }
    if (this._options.exist(OptionTarget.cost)) {
      cost = this._options.cost().value();
    }

    final salt = '\$$algo\$$cost\$${this._preset.salt()}';

    var reversed = '';
    var encrypted = '$rndInt${this._target}';
    while (reversed.length < len) {
      encrypted = DBCrypt().hashpw(encrypted, salt);
      for (var i = encrypted.length - 1; 29 <= i; i--) {
        reversed += encrypted[i];
      }
    }

    var symbols = this._preset.symbols().value();
    if (this._options.exist(OptionTarget.sym)) {
      symbols = this._options.symbols().value();
    }

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