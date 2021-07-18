import 'dart:math';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:dhak/args/options.dart';
import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:dhak/cmd/generate/password_status.dart';
import 'package:dhak/config/preset.dart';
import 'package:dhak/crypto/gen_salt.dart';

class PasswordGen {
  final String _target;
  final Preset _preset;
  final Options _options;

  PasswordGen(this._target, this._preset, this._options);

  String getPassword() {
    var force = this._options.exist(OptionTarget.force);
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
    final salt = this._getSalt();

    // Add hash until password exceeds passLength.
    var hash = '';
    var encrypted = '$rndInt${this._target}';
    var len = this._getPassLength(force);
    while (hash.length < len) {
      encrypted = DBCrypt().hashpw(encrypted, salt);

      // Extract only hash value.
      for (var i = encrypted.length - 1; 29 <= i; i--) {
        hash += encrypted[i];
      }
    }

    var password = hash.substring(0, len);

    // Remove symbols which exist from the beginning.
    final operator = PasswordOperator(password);
    password = operator.replaceSymbols();

    var symbols = this._getSymbols();
    if (symbols.length != 0) {
      password = operator.replaceAtRandomWith(symbols);
    }

    return password;
  }

  int _getPassLength(bool force) {
    var len = this._preset.passLength().value(force);
    if (this._options.exist(OptionTarget.len)) {
      len = this._options.passLength().value(force);
    }
    return len;
  }

  List<String> _getSymbols() {
    var sym = this._preset.symbols().value();
    if (this._options.exist(OptionTarget.sym)) {
      sym = this._options.symbols().value();
    }
    return sym;
  }

  String _getSalt() {
    var algo = this._getAlgo();
    var cost = this._getCost();
    var hashCode = this._target.hashCode;
    return '\$$algo\$$cost\$${GenSalt.fromHashCode(hashCode)}';
  }

  String _getAlgo() {
    var algo = this._preset.algorithm().value();
    if (this._options.exist(OptionTarget.algo)) {
      algo = this._options.algorithm().value();
    }
    return algo;
  }

  String _getCost() {
    var cost = this._preset.cost().value();
    if (this._options.exist(OptionTarget.cost)) {
      cost = this._options.cost().value();
    }
    return cost;
  }
}
