import 'package:dhak/items_for_gen_pass/algorithm.dart';
import 'package:dhak/items_for_gen_pass/cost.dart';
import 'package:dhak/items_for_gen_pass/pass_length.dart';
import 'package:dhak/items_for_gen_pass/symbols.dart';
import 'package:dhak/settings/settings.dart';

class Preset extends Settings {
  final String _name;
  final String _passLength;
  final String _symbols;
  final String _algo;
  final String _cost;

  Preset(this._name, this._passLength, this._symbols, this._algo, this._cost);

  String name() => this._name;

  @override
  PassLength passLength() => PassLength(this._passLength);

  @override
  Symbols symbols() => Symbols(this._symbols);

  @override
  Algorithm algorithm() => Algorithm(this._algo);

  @override
  Cost cost() => Cost(this._cost);
}
