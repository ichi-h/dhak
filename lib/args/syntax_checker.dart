import 'package:dhak/util/dhak_exception.dart' show DhakArgsException;
import 'package:dhak/args/args_status.dart';

class SyntaxChecker {
  late final List<String> args;
  late final ArgsStatus _procArgs;

  SyntaxChecker(List<String> args) {
    this.args = args;
    this._procArgs = new ArgsStatus(args);
  }

  List<String> checkedArgs() {
    try {
      return this.check();
    } on DhakArgsException catch (e) {
      print(e.message);
      return ['', '', '--help'];
    }
  }

  List<String> check() {
    final result;

    switch (this.args.length) {
      case 1:
        result = this._caseOne();
        break;

      case 2:
        result = this._caseTwo();
        break;

      case 3:
        result = this._caseThree();
        break;

      default:
        throw new DhakArgsException(
            'Syntax error: The length of the command-line arguments must be less than or equal to 3.\n');
    }

    return result;
  }

  List<String> _caseOne() {
    if (this._procArgs.isOption(0)) {
      return ['', '', this.args[0]];
    }

    return [this.args[0], 'default', ''];
  }

  List<String> _caseTwo() {
    if (this._procArgs.isOption(0)) {
      this._hyphenException();
    }

    if (this._procArgs.isOption(1)) {
      return [this.args[0], 'default', this.args[1]];
    }

    return [this.args[0], this.args[1], ''];
  }

  List<String> _caseThree() {
    if (this._procArgs.isOption(0) || this._procArgs.isOption(1)) {
      this._hyphenException();
    }

    if (this._procArgs.optionIndex() == -1) {
      var errorArg = this.args[2];
      throw new DhakArgsException(
          'Syntax error: The argument "$errorArg (2)" does not match the syntax of dhak.\n');
    }

    return this.args;
  }

  void _hyphenException() {
    throw new DhakArgsException(
        'Syntax error: Hyphens are not allowed in the first character of the <title> and <preset>.\n');
  }
}
