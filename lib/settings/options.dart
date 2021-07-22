import 'package:dhak/items_for_gen_pass/algorithm.dart';
import 'package:dhak/items_for_gen_pass/cost.dart';
import 'package:dhak/items_for_gen_pass/pass_length.dart';
import 'package:dhak/items_for_gen_pass/symbols.dart';
import 'package:dhak/settings/settings.dart';

enum OptionTarget { force, display, len, sym, algo, cost }

typedef _Callback<T> = T Function(String option);

class Options extends Settings {
  final List<String> _options;

  Options(this._options);

  List<String> toList() => this._options;

  bool exist(OptionTarget target) {
    for (var option in this._options) {
      if (this._equals(option, target)) return true;
    }
    return false;
  }

  @override
  PassLength passLength() {
    final len = this._procMatchedOpt<String>(OptionTarget.len, (opt) {
      return opt.replaceAll('--len=', '');
    });
    return PassLength(len);
  }

  @override
  Symbols symbols() {
    var sym = this._procMatchedOpt<String>(OptionTarget.sym, (opt) {
      return opt.replaceAll('--sym=', '');
    });

    return Symbols(sym);
  }

  @override
  Algorithm algorithm() {
    final algo = this._procMatchedOpt<String>(OptionTarget.algo, (opt) {
      return opt.replaceAll('--algo=', '');
    });
    return Algorithm(algo);
  }

  @override
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
    throw _NoReturnValueException('There is no option matched with "$target".');
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

class _NoReturnValueException implements Exception {
  final String message;

  _NoReturnValueException(this.message);
}
