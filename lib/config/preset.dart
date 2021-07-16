import 'package:dhak/crypto/gen_salt.dart';
import 'package:dhak/util/code_unit_range.dart';
import 'package:dhak/util/dhak_exception.dart';

class Preset {
  late final String _name;
  late final int _passLength;
  late final List<String> _symbols;
  late String _salt;

  Preset(this._name, this._passLength, this._symbols, this._salt);

  static Preset newInstance(
      String presetName, Map<String, dynamic> doc, int hashCode) {
    var name = presetName;

    final preset = doc['presets'][presetName];

    if (preset == null) {
      throw DhakRuntimeException(
          'Runtime error: The preset name "$presetName" was not found.');
    }

    var passLength = preset['password_length'];
    var salt = '\$${preset['algorithm']}' +
        '\$${preset['cost']}' +
        '\$${GenSalt.fromHashCode(hashCode)}';

    List<dynamic> dynSymbols = preset['symbols'].toList();
    var symbols = dynSymbols.map((e) => e as String).toList();

    return Preset(name, passLength, symbols, salt);
  }

  String name() {
    if (this._name.startsWith('-')) {
      throw DhakRuntimeException(
          'Preset error: The preset name "${this._name}" is invalid. '
          'You cannot use a name which starts with a hyphen.');
    }
    return this._name;
  }

  int passLength(String option) {
    if (this._passLength < 8 && !option.contains('f')) {
      throw DhakRuntimeException(
          'Preset error: The password length "${this._passLength}" is invalid. '
          'The length must be more than 8.');
    }

    if (this._passLength < 12) {
      print(
          'WARNING: The password length which is "${this._passLength}" is a short. '
          'It should be more than 12.');
    }

    return this._passLength;
  }

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

  String salt() {
    if (this._salt == '') return this._salt;

    var saltInfo = this._salt.split(r'$');

    var algorithm = saltInfo[1];
    if (algorithm != '2' &&
        algorithm != '2a' &&
        algorithm != '2y' &&
        algorithm != '2b') {
      throw DhakRuntimeException(
          'Preset error: The unknown algorithm "$algorithm" was found.');
    }

    var cost = int.parse(saltInfo[2]);
    if (cost < 4 || 31 < cost) {
      throw DhakRuntimeException('Preset error: The cost "$cost" is invalid.'
          'It must be between 4 and 31.');
    }

    var salt = saltInfo[3];
    if (salt.length != 22) {
      throw DhakRuntimeException('Preset error: The salt length must be 22.');
    }

    return this._salt;
  }

  void setSalt(String salt) {
    this._salt = salt;
  }
}
