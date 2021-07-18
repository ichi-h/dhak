import 'package:dhak/items_for_gen_pass/item.dart';
import 'package:dhak/util/dhak_exception.dart';

class Algorithm extends Item<String> {
  final String _algo;

  Algorithm(this._algo);

  @override
  String value() {
    if (!this._isValidAlgo(this._algo)) {
      throw DhakRuntimeException(
          'Runtime error: The unknown algorithm "${this._algo}" was found.');
    }
    return this._algo;
  }

  bool _isValidAlgo(String algo) {
    return algo == '2' || algo == '2a' || algo == '2y' || algo == '2b';
  }
}
