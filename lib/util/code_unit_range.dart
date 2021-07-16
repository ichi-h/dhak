class CodeUnitRange {
  static bool isLowerCase(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 97, 122);
  }

  static bool isUpperCase(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 65, 90);
  }

  static bool isNumber(int utf16CodeUnit) {
    return _inRange(utf16CodeUnit, 48, 57);
  }

  static bool _inRange(int target, int lower, int upper) {
    if (lower <= target && target <= upper) return true;
    return false;
  }
}
