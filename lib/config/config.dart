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
    return r'''# Presets which dhak uses when it generates passwords.
# If you want to add a new preset, write a setting follow the format
# below.
presets:

  # Preset name.
  # You can use the preset named "default" when you omit the <preset>
  # argument of the dhak command (of course, you can use it without
  # omitting it).
  default:

    # Length of generated password. (8-31)
    password_length: 20

    # Symbols used for passwords.
    # You can use any symbols except lower-case, upper-case and numbers.
    # If you keep this empty, you will get passwords without symbols.
    symbols: [ "/", "#", "%", "&", "@", "+", "-", "_" ]

    # Salt of BCrypt (DANGER)
    # IF YOU CHANGE THIS VALUE, THE OUTPUT PASSWORD WILL ALSO CHANGE!
    # BASICALLY, YOU DO NOT HAVE TO CHANGE IT.
    #
    # When you add a new preset, set the value to "".
    # Then, the first time you generate a password, dhak will overwrite
    # it with something like the following string.
    #
    # - $2b$10$gEFq.t64qSdMqKw3NHR0YO
    #   - $2b
    #     - Algorithm of generating hash. (2, 2a, 2y, 2b)
    #   - $10
    #     - 2^n rounds of stretching. (4 <= n <= 31)
    #   - $gEFq.t64qSdMqKw3NHR0YO
    #     - String appended to the title and passphrase.
    #     - The length of it must be 22.
    #     - It is preferable to be a different value from the others.
    salt: ""
''';
  }
}
