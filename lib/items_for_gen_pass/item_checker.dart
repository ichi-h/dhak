class ItemChecker {
  static bool canParseInt(String target) {
    try {
      int.parse(target);
    } catch (e) {
      return false;
    }

    return true;
  }
}
