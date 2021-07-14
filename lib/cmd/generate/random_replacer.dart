import 'dart:math';

class RandomReplacer {
  final String password;

  RandomReplacer(this.password);

  String replaceBy(List<String> symbols) {
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

    print(this.password);
    print(result);

    return result;
  }
}
