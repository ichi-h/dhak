import 'dart:math';

import 'package:dhak/util/code_unit_range.dart';
import 'package:dhak/util/global_const.dart';

class PasswordOperator {
  static String replaceAtRandomWith(String password, List<String> symbols) {
    final rnd = Random(password.hashCode);
    final passLen = password.length;

    // Calculate trials of replacements.
    // It is adjusted to be from 1 to one third of password length.
    var maxTrials = (passLen / 3).round();
    final trials = 1 + rnd.nextInt(maxTrials) % maxTrials;

    var result = password;

    for (var i = 0; i < trials; i++) {
      var targetIndex = rnd.nextInt(passLen);
      var symbol = symbols[rnd.nextInt(symbols.length)];
      result = result.replaceRange(targetIndex, targetIndex + 1, symbol);
    }

    return result;
  }

  static String replaceSymbols(String password) {
    final rnd = Random(password.hashCode);
    final letterLen = GlobalConst.letters.length;

    var result = password;

    for (var i = 0; i < password.length; i++) {
      var char = password[i];
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
}
