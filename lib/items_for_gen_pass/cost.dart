import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/items_for_gen_pass/item_checker.dart';
import 'package:dhak/util/dhak_exception.dart';

class Cost extends Item<int> {
  final String _cost;

  Cost(this._cost);

  @override
  int value() {
    if (!ItemChecker.canParseInt(this._cost)) {
      throw DhakRuntimeException(
          'Runtime error: The cost "${this._cost}" is invalid.'
          'It must be an integer between 4 and 31.');
    }

    int cost = int.parse(this._cost);
    if (!this._isValidCost(cost)) {
      throw DhakRuntimeException(
          'Runtime error: The cost "${this._cost}" is invalid.'
          'It must be an integer between 4 and 31.');
    }

    return cost;
  }

  bool _isValidCost(int cost) => 4 <= cost && cost <= 31;
}
