import 'package:console/console.dart';
import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/items_for_gen_pass/item_checker.dart';
import 'package:dhak/util/color_print.dart';
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
          'It must be 12 or more.');
    }

    return len;
  }

  bool _passLenIsSafety(int len, bool force) {
    if (len < 12 && !force) {
      return false;
    }

    if (len < 12) {
      var text = 'WARNING: The password length "$len" is too short. '
          'It should be more than 12.';
      colorPrint(text, Color.YELLOW);
    }

    return true;
  }
}
