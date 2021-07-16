import 'package:dhak/util/code_unit_range.dart';

class PasswordStatus {
  final String password;

  PasswordStatus(this.password);

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

    if (this.password.length < 8) return false;

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
