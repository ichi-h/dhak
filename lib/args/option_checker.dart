class OptionChecker {
  static bool passLenIsSafety(int len, bool force) {
    if (len < 8 && !force) {
      return false;
    }

    if (len < 12) {
      print('WARNING: The length of password is "$len", which is short. '
          'It should be more than 12.');
    }

    return true;
  }

  static bool canParseInt(String target) {
    try {
      int.parse(target);
    } catch (e) {
      return false;
    }

    return true;
  }

  static bool isValidAlgo(String algo) {
    return algo == '2' || algo == '2a' || algo == '2y' || algo == '2b';
  }

  static bool isValidCost(int cost) {
    return 4 <= cost && cost <= 31;
  }
}
