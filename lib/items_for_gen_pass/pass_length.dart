import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/items_for_gen_pass/item_checker.dart';
import 'package:dhak/util/dhak_exception.dart';

class PassLength extends Item<int> {
  final String _len;

  PassLength(this._len);

  @override
  int value([bool force = false]) {
    if (!ItemChecker.canParseInt(this._len)) {
      throw DhakRuntimeException(
          'Runtime error: The password length "${this._len}" is invalid.'
          'It must be an integer.');
    }

    var len = int.parse(this._len);
    if (!this._passLenIsSafety(len, force)) {
      throw DhakRuntimeException(
          'Preset error: The password length "${this._len}" is invalid. '
          'It must be 8 or more.');
    }

    return len;
  }

  bool _passLenIsSafety(int len, bool force) {
    if (len < 8 && !force) {
      return false;
    }

    if (len < 12) {
      print('WARNING: The password length is "$len", which is short. '
          'It should be more than 12.');
    }

    return true;
  }
}
