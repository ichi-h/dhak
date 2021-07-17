import 'package:dhak/args/option_checker.dart';
import 'package:dhak/util/code_unit_range.dart';
import 'package:dhak/util/dhak_exception.dart';

enum _Target { force, display, len, sym, algo, cost }

typedef _Callback<T> = T Function(String option);

class Options {
  final List<String> _options;

  Options(this._options);

  List<String> toList() => this._options;

  bool haveForce() {
    return this._procMatchedOpt<bool>(_Target.force, false, (opt) => true);
  }

  bool haveDisplay() {
    return this._procMatchedOpt<bool>(_Target.display, false, (opt) => true);
  }

  int passLength(int defLen) {
    final lenStr =
        this._procMatchedOpt<String>(_Target.len, defLen.toString(), (opt) {
      return opt.replaceAll('--len=', '');
    });

    if (!OptionChecker.canParseInt(lenStr)) {
      throw DhakRuntimeException(
          'Runtime error: The value "$lenStr" of the option "--len" is invalid.');
    }

    var len = int.parse(lenStr);
    if (!OptionChecker.passLenIsSafety(len, this.haveForce())) {
      throw DhakRuntimeException(
          'Preset error: The password length "$len" is invalid. '
          'The length must be more than 8.');
    }

    return len;
  }

  List<String> symbols(List<String> defSym) {
    final sym = this._procMatchedOpt<List<String>>(_Target.sym, defSym, (opt) {
      var symStr = opt.replaceAll('--sym=', '');
      return symStr.split('');
    });

    return sym.where((symbol) {
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

  String algorithm(String defAlgo) {
    final algo = this._procMatchedOpt<String>(_Target.algo, defAlgo, (opt) {
      return opt.replaceAll('--algo=', '');
    });

    if (!OptionChecker.isValidAlgo(algo)) {
      throw DhakRuntimeException(
          'Preset error: The unknown algorithm "$algo" was found.');
    }

    return algo;
  }

  String cost(String defCost) {
    final cost = this._procMatchedOpt<String>(_Target.cost, defCost, (opt) {
      return opt.replaceAll('--cost=', '');
    });

    if (!OptionChecker.canParseInt(cost)) {
      throw DhakRuntimeException(
          'Runtime error: The value "$cost" of the option "--cost" is invalid.');
    }

    int costInt = int.parse(cost);
    if (!OptionChecker.isValidCost(costInt)) {
      throw DhakRuntimeException('Preset error: The cost "$cost" is invalid.'
          'It must be between 4 and 31.');
    }

    return cost;
  }

  T _procMatchedOpt<T>(_Target target, T defValue, _Callback<T> callback) {
    for (var opt in this._options) {
      if (this._equals(opt, target)) {
        return callback(opt);
      }
    }
    return defValue;
  }

  bool _equals(String option, _Target target) {
    var isDouble = option.startsWith('--');
    switch (target) {
      case _Target.force:
        return !isDouble && option.contains('f') || option == '--force';

      case _Target.display:
        return !isDouble && option.contains('d') || option == '--display';

      case _Target.len:
        return option.contains('--len=');

      case _Target.sym:
        return option.contains('--sym=');

      case _Target.algo:
        return option.contains('--algo=');

      case _Target.cost:
        return option.contains('--cost=');
    }
  }
}
