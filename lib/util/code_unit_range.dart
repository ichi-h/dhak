class CodeUnitRange {
  static bool isLowerCase(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 97, 122); // a-z
  }

  static bool isUpperCase(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 65, 90); // A-Z
  }

  static bool isNumber(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 48, 57); // 0-9
  }

  static bool _inRange(int target, int lower, int upper) {
    if (lower <= target && target <= upper) return true;
    return false;
  }
}
