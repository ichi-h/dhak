import 'package:dhak/items_for_gen_pass/item_checker.dart';
import 'package:dhak/items_for_gen_pass/algorithm.dart';
import 'package:dhak/items_for_gen_pass/cost.dart';
import 'package:dhak/items_for_gen_pass/pass_length.dart';
import 'package:dhak/items_for_gen_pass/symbols.dart';
import 'package:dhak/util/code_unit_range.dart';
import 'package:dhak/util/dhak_exception.dart';

enum OptionTarget { force, display, len, sym, algo, cost }

typedef _Callback<T> = T Function(String option);

class Options {
  final List<String> _options;

  Options(this._options);

  List<String> toList() => this._options;

  bool exist(OptionTarget target) {
    for (var option in this._options) {
      if (this._equals(option, target)) return true;
    }
    return false;
  }

  bool haveForce() {
    return this._procMatchedOpt<bool>(OptionTarget.force, (opt) => true);
  }

  bool haveDisplay() {
    return this._procMatchedOpt<bool>(OptionTarget.display, (opt) => true);
  }

  PassLength passLength() {
    final len = this._procMatchedOpt<String>(OptionTarget.len, (opt) {
      return opt.replaceAll('--len=', '');
    });
    return PassLength(len);
  }

  Symbols symbols() {
    var sym = this._procMatchedOpt<String>(OptionTarget.sym, (opt) {
      return opt.replaceAll('--sym=', '');
    });
    
    return Symbols(sym);
  }

  Algorithm algorithm() {
    final algo = this._procMatchedOpt<String>(OptionTarget.algo, (opt) {
      return opt.replaceAll('--algo=', '');
    });
    return Algorithm(algo);
  }

  Cost cost() {
    final cost = this._procMatchedOpt<String>(OptionTarget.cost, (opt) {
      return opt.replaceAll('--cost=', '');
    });
    return Cost(cost);
  }

  T _procMatchedOpt<T>(OptionTarget target, _Callback<T> callback) {
    for (var opt in this._options) {
      if (this._equals(opt, target)) {
        return callback(opt);
      }
    }
    throw ArgumentError('There is no option matched with "$target".');
  }

  bool _equals(String option, OptionTarget target) {
    var isDouble = option.startsWith('--');
    switch (target) {
      case OptionTarget.force:
        return !isDouble && option.contains('f') || option == '--force';

      case OptionTarget.display:
        return !isDouble && option.contains('d') || option == '--display';

      case OptionTarget.len:
        return option.contains('--len=');

      case OptionTarget.sym:
        return option.contains('--sym=');

      case OptionTarget.algo:
        return option.contains('--algo=');

      case OptionTarget.cost:
        return option.contains('--cost=');
    }
  }
}
