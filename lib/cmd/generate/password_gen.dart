import 'dart:math';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:dhak/cmd/generate/password_status.dart';

class PasswordGen {
  final String _target;
  final int _len;
  final List<String> _sym;
  final String _salt;
  final bool _force;

  PasswordGen(this._target, this._len, this._sym, this._salt, this._force);

  String getPassword() {
    var password = this._genPassword();

    final rnd = Random(password.hashCode);
    PasswordStatus status = PasswordStatus(password);
    while (!status.isSecure(this._force)) {
      var num = rnd.nextInt(100) + 1;
      password = this._genPassword(num);
      status = PasswordStatus(password);
    }

    return password;
  }

  String _genPassword([int rndInt = 0]) {
    // Add hash until password exceeds passLength.
    var hash = '';
    var encrypted = '$rndInt${this._target}';
    while (hash.length < this._len) {
      encrypted = DBCrypt().hashpw(encrypted, this._salt);

      // Extract only hash value.
      for (var i = encrypted.length - 1; 29 <= i; i--) {
        hash += encrypted[i];
      }
    }

    var password = hash.substring(0, this._len);

    // Remove symbols which exist from the beginning.
    password = PasswordOperator.replaceSymbols(password);

    if (this._sym.length != 0) {
      password = PasswordOperator.replaceAtRandomWith(password, this._sym);
    }

    return password;
  }
}
