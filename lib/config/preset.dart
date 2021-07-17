import 'package:dhak/util/code_unit_range.dart';

class Preset {
  late final String _name;
  late final int _passLength;
  late final List<String> _symbols;
  late String _salt;

  Preset(this._name, this._passLength, this._symbols, this._salt);

  String name() => this._name;

  int passLength() => this._passLength;

  List<String> symbols() {
    return this._symbols.where((symbol) {
      var unit = symbol.codeUnitAt(0);
      var status = !CodeUnitRange.isLowerCase(unit) &&
          !CodeUnitRange.isUpperCase(unit) &&
          !CodeUnitRange.isNumber(unit);

      if (!status) {
        print('Notice: The symbol "$symbol" was ignored.');
      }

      return status;
    }).toList();
  }

  String salt() => this._salt;

  void setSalt(String salt) {
    this._salt = salt;
  }
}
