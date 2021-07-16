import 'dart:math';

import 'package:dhak/util/global_const.dart';

class GenSalt {
  static String fromHashCode(int hashCode) {
    final symbols = ['/', '.'];
    final saltLetters =
        [GlobalConst.letters, symbols].expand((char) => char).toList();

    var result = '';
    final rnd = Random(hashCode);
    for (var i = 0; i < 22; i++) {
      var index = rnd.nextInt(saltLetters.length);
      result += saltLetters[index];
    }

    return result;
  }
}
