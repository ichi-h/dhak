import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/util/code_unit_range.dart';

class Symbols extends Item<List<String>> {
  final String _sym;

  Symbols(this._sym);

  @override
  List<String> value() {
    // toSet() is measure for duplication of symbols
    var symbols = this._sym.split('').toSet();

    return symbols.where((symbol) {
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
}
