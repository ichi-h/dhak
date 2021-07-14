import 'dart:math';

import 'package:dhak/util/global_const.dart';

class PasswordOperator {
  final String password;

  PasswordOperator(this.password);

  String replaceAtRandomWith(List<String> symbols) {
    final rnd = Random(this.password.hashCode);
    final passLen = this.password.length;

    // Calculate trials of replacements.
    // It is adjusted to be from 1 to a quarter of password length.
    final trials = 1 + rnd.nextInt(passLen) % (passLen / 4).floor();

    var result = this.password;

    for (var i = 0; i < trials; i++) {
      var targetIndex = rnd.nextInt(passLen);
      var symbol = symbols[rnd.nextInt(symbols.length)];
      result = result.replaceRange(targetIndex, targetIndex + 1, symbol);
    }

    return result;
  }

  bool hasSymbols() {
    var result = this.password;

    for (var char in GlobalConst.LOWER_CASE) {
      result = result.replaceAll(char, '');
    }

    for (var char in GlobalConst.UPPER_CASE) {
      result = result.replaceAll(char, '');
    }

    for (var num in GlobalConst.NUMBERS) {
      result = result.replaceAll(num.toString(), '');
    }

    if (0 < result.length) return true;

    return false;
  }

  bool isSecure() {
    var result = {'lowerCase': false, 'upperCase': false, 'numbers': false};

    for (var char in GlobalConst.LOWER_CASE) {
      if (this.password.contains(char)) {
        result['lowerCase'] = true;
        break;
      }
    }

    for (var char in GlobalConst.UPPER_CASE) {
      if (this.password.contains(char)) {
        result['upperCase'] = true;
        break;
      }
    }

    for (var num in GlobalConst.NUMBERS) {
      if (this.password.contains(num.toString())) {
        result['numbers'] = true;
        break;
      }
    }

    if (result['lowerCase']! && result['upperCase']! && result['numbers']!) {
      return true;
    }

    return false;
  }
}
