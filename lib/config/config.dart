import 'dart:io';
import 'package:dhak/config/preset.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:yaml/yaml.dart';

class Config {
  late final file;

  Config([String path = '~/.dhak/config.yaml']) {
    this.file = File(path);
  }

  Preset getPreset(String presetName) {
    if (!this.file.existsSync()) {
      this._writeConfig();
    }

    final doc = this._getDoc();
    final preset = doc['presets'][presetName];

    if (preset == null) {
      throw DhakRuntimeException(
          'Runtime error: The preset name $presetName was not found.');
    }

    int passLength = preset['password_length'];
    String salt = preset['salt'];

    List<dynamic> dynSymbols = preset['symbols'].toList();
    List<String> symbols = dynSymbols.map((e) => e as String).toList();

    return Preset(presetName, passLength, symbols, salt);
  }

  dynamic _getDoc() {
    var contents = this.file.readAsStringSync();
    return loadYaml(contents);
  }

  void _writeConfig() {
    print('"config.json" was not found.');
    print('Initializing "config.json" now...');
    var yaml = Config._stringConfig();
    this.file.writeAsStringSync(yaml);
    print('Finished!');
  }

  static String _stringConfig() {
    return r'''{
  "presets": {
    "default": {
      "password_length": 20,
      "symbols": [
        "/",
        "#",
        "%",
        "&",
        "@",
        "+",
        "-",
        "_"
      ],
      "salt": ""
    }
  }
}''';
  }
}
