import 'dart:convert';
import 'dart:io';

import 'package:dhak/config/preset.dart';
import 'package:dhak/crypto/gen_salt.dart';
import 'package:dhak/util/dhak_exception.dart';

class Config {
  late final file;
  late Map<String, dynamic> _doc;

  Config(String path) {
    this.file = File(path);

    if (!this.file.existsSync()) {
      print('"$path" was not found.');
      print('Creating "$path" now...');
      var json = Config._stringConfig();
      this.file.writeAsStringSync(json);
      print('Finished!\n');
    }

    var contents = this.file.readAsStringSync();
    this._doc = json.decode(contents);
  }

  Preset getPreset(String presetName, int hashCode) {
    final preset = this._doc['presets'][presetName];
    if (preset == null) {
      throw DhakRuntimeException(
          'Runtime error: The preset name "$presetName" was not found.');
    }

    int? passLength = preset['password_length'];
    passLength ??= 20;

    String? symStr = preset['symbols'];
    symStr ??= '!"#\$%&‘()*+,-./:;<=>?@[\\}^_`{|}~';
    var symbols = symStr.split('');

    String? algo = preset['algorithm'];
    String? cost = preset['cost'];
    algo ??= '2b';
    cost ??= '10';
    var salt = GenSalt.fromHashCode(hashCode);

    return Preset(presetName, passLength, symbols, algo, cost, salt);
  }

  static String _stringConfig() {
    return r'''{
  "presets": {
    "default": {
      "password_length": 20,
      "symbols": "!\"#$%&‘()*+,-./:;<=>?@[\\}^_`{|}~",
      "algorithm": "2b",
      "cost": "10"
    }
  }
}''';
  }
}
