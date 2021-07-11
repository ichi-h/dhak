import 'package:dhak/dhak_exception.dart' show DhakSyntaxException;
import 'package:dhak/args/process_args.dart';

class SyntaxChecker {
  late final List<String> args;
  late final ProcessArgs _procArgs;

  SyntaxChecker(List<String> args) {
    this.args = args;
    this._procArgs = new ProcessArgs(args);
  }

  List<String> checkedArgs() {
    try {
      return this.check();
    } on DhakSyntaxException catch (e) {
      print(e.message);
      return ['--help'];
    }
  }

  List<String> check() {
    if (3 < this.args.length) {
      throw new DhakSyntaxException('Syntax error: The length of the command-line arguments must be less than or equal to 3.\n');
    }

    switch (this.args.length) {
      case 1:
        if (this._procArgs.isOption(0) && !this._procArgs.isOptionHelp(0)) {
          this._hyphenException();
        }

        break;

      case 2:
        if (this._procArgs.isOption(0)) {
          this._hyphenException();
        }

        break;

      case 3:
        if (this._procArgs.isOption(0) || this._procArgs.isOption(1)) {
          this._hyphenException();
        }

        if (this._procArgs.optionIndex() == -1) {
          var errorArg = this.args[2];
          throw new DhakSyntaxException('Syntax error: The argument "$errorArg (2)" does not match the syntax of dhak.\n');
        }

        break;
    }

    return this.args;
  }

  void _hyphenException() {
    throw new DhakSyntaxException('Syntax error: Hyphens are not allowed in the first character of the <title> and <preset>.\n');
  }
}
