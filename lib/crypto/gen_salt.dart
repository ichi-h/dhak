import 'dart:math';

import 'package:dbcrypt/dbcrypt.dart';

class GenSalt {
  static String generateSaltFromRnd(int seed, String algo, int cost) {
    final rnd = Random(seed);
    var salt = DBCrypt().gensaltWithRoundsAndRandom(cost, rnd);
    salt = salt.replaceFirst('\$2b', '\$$algo');
    return salt;
  }
}
