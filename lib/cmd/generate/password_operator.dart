import 'dart:math';

import 'package:dhak/cmd/generate/code_unit_range.dart';
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

  String replaceSymbols() {
    final rnd = Random(this.password.hashCode);
    final letterLen = GlobalConst.letters.length;

    var result = this.password;

    for (var i = 0; i < this.password.length; i++) {
      var char = this.password[i];
      var unit = char.codeUnitAt(0);

      if (!CodeUnitRange.isLowerCase(unit) &&
          !CodeUnitRange.isUpperCase(unit) &&
          !CodeUnitRange.isNumber(unit)) {
        var index = rnd.nextInt(letterLen);
        var newChar = GlobalConst.letters[index];
        result = result.replaceRange(i, i + 1, newChar);
      }
    }

    return result;
  }

  bool hasSymbols() {
    var result = this.password;

    for (var i = 0; i < this.password.length; i++) {
      var char = this.password[i];
      var unit = char.codeUnitAt(0);

      if (CodeUnitRange.isLowerCase(unit) ||
          CodeUnitRange.isUpperCase(unit) ||
          CodeUnitRange.isNumber(unit)) {
        result = result.replaceAll(char, '');
      }
    }

    if (0 < result.length) return true;

    return false;
  }

  bool isSecure() {
    var result = {'lowerCase': false, 'upperCase': false, 'number': false};

    for (var i = 0; i < this.password.length; i++) {
      var unit = this.password[i].codeUnitAt(0);

      if (CodeUnitRange.isLowerCase(unit)) {
        result['lowerCase'] = true;
      } else if (CodeUnitRange.isUpperCase(unit)) {
        result['upperCase'] = true;
      } else if (CodeUnitRange.isNumber(unit)) {
        result['number'] = true;
      }
    }

    if (result['lowerCase']! && result['upperCase']! && result['number']!) {
      return true;
    }

    return false;
  }
}
