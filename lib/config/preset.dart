import 'package:dhak/util/dhak_exception.dart';

class Preset {
  late final String _name;
  late final int _passLength;
  late final List<String> _symbols;
  late String _salt;

  Preset(String presetName, Map<String, dynamic> doc) {
    final preset = doc['presets'][presetName];

    if (preset == null) {
      throw DhakRuntimeException(
          'Runtime error: The preset name $presetName was not found.');
    }

    this._passLength = preset['password_length'];
    this._salt = preset['salt'];

    List<dynamic> dynSymbols = preset['symbols'].toList();
    this._symbols = dynSymbols.map((e) => e as String).toList();
  }

  String name() => this._name;

  int passLength() => this._passLength;

  List<String> symbols() => this._symbols;

  String salt() => this._salt;

  void setSalt(String salt) {
    this._salt = salt;
  }
}
