import 'package:console/console.dart';
import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/util/code_unit_range.dart';
import 'package:dhak/util/color_print.dart';

class Symbols extends Item<List<String>> {
  final String _sym;

  Symbols(this._sym);

  @override
  List<String> value() {
    // toSet() is measure for duplication of symbols
    var symbols = this._sym.split('').toSet();

    var result = symbols.where((symbol) {
      var unit = symbol.codeUnitAt(0);
      var status = !CodeUnitRange.isLowerCase(unit) &&
          !CodeUnitRange.isUpperCase(unit) &&
          !CodeUnitRange.isNumber(unit);

      if (!status) {
        print('Notice: The symbol "$symbol" was ignored.');
      }

      return status;
    }).toList();

    if (result.length == 0) {
      var text = 'WARNING: The password does not contain any symbols.';
      colorPrint(text, Color.YELLOW);
    }

    return result;
  }
}
