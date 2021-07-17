import 'package:dhak/util/dhak_exception.dart';

enum _Target { force, display, passLength, algorithm, cost }

typedef _Callback<T> = T Function(String option);

class Options {
  final List<String> _options;

  Options(this._options);

  List<String> toList() => this._options;

  bool haveForce() {
    return this
        ._processMatchedOption<bool>(_Target.force, false, (option) => true);
  }

  bool haveDisplay() {
    return this
        ._processMatchedOption<bool>(_Target.display, false, (option) => true);
  }

  int passLength(int defaultLen) {
    return this._processMatchedOption<int>(_Target.passLength, defaultLen,
        (option) {
      var intStr = option.replaceAll('--len=', '');

      try {
        return int.parse(intStr);
      } catch (e) {
        throw DhakRuntimeException(
            'Runtime error: The value "$intStr" of the option "--len" is invalid.');
      }
    });
  }

  String algorithm(String defaultAlgo) {
    return this._processMatchedOption<String>(_Target.algorithm, defaultAlgo,
        (option) {
      return option.replaceAll('--algo=', '');
    });
  }

  String cost(String defaultConst) {
    return this._processMatchedOption<String>(_Target.cost, defaultConst,
        (option) {
      var result = option.replaceAll('--cost=', '');

      try {
        int.parse(result);
      } catch (e) {
        throw DhakRuntimeException(
            'Runtime error: The value "$result" of the option "--cost" is invalid.');
      }

      return result;
    });
  }

  T _processMatchedOption<T>(_Target target, T error, _Callback<T> callback) {
    for (var option in this._options) {
      if (this._equals(option, target)) {
        var result = callback(option);
        return result;
      }
    }
    return error;
  }

  bool _equals(String option, _Target target) {
    var isDouble = option.startsWith('--');
    switch (target) {
      case _Target.force:
        return !isDouble && option.contains('f') || option == '--force';

      case _Target.display:
        return !isDouble && option.contains('d') || option == '--display';

      case _Target.passLength:
        return option.contains('--len=');

      case _Target.algorithm:
        return option.contains('--algo=');

      case _Target.cost:
        return option.contains('--cost=');
    }
  }
}
