import 'package:dhak/items_for_gen_pass/algorithm.dart';
import 'package:dhak/items_for_gen_pass/cost.dart';
import 'package:dhak/items_for_gen_pass/pass_length.dart';
import 'package:dhak/items_for_gen_pass/symbols.dart';

class Preset {
  final String _name;
  final int _passLength;
  final List<String> _symbols;
  final String _algo;
  final String _cost;
  final String _salt;

  Preset(this._name, this._passLength, this._symbols, this._algo, this._cost,
      this._salt);

  String name() => this._name;

  PassLength passLength() => PassLength(this._passLength);

  Symbols symbols() => Symbols(this._symbols);

  Algorithm algorithm() => Algorithm(this._algo);

  Cost cost() => Cost(this._cost);

  String salt() => this._salt;
}
