import 'package:dhak/dhak_exception.dart' show DhakSyntaxException;

class ArgsChecker {
  final List<String> args;
  ArgsChecker(this.args);

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
      throw new DhakSyntaxException('Syntax error: The length of the command-line argument must be less than or equal to 3.\n');
    }

    switch (this.args.length) {
      case 1:
        if (this._isOption(0) && !_isOptionHelp(0)) {
          this._hyphenException();
        }

        break;

      case 2:
        if (this._isOption(0)) {
          this._hyphenException();
        }

        break;

      case 3:
        if (this._isOption(0) || this._isOption(1)) {
          this._hyphenException();
        }

        if (this._optionIndex() == -1) {
          var unknownValue = this.args[2];
          throw new DhakSyntaxException('Syntax error: The argument "$unknownValue (2)" does not match the syntax of dhak.\n');
        }

        break;
    }

    return this.args;
  }

  bool _isOption(int index) {
    return this.args[index].startsWith('-');
  }

  bool _isOptionHelp(int index) {
    return this.args[index] == '-h' || this.args[index] == '--help';
  }

  int _optionIndex() {
    return this.args.indexWhere(
      (arg) => arg.startsWith('-')
    );
  }

  void _hyphenException() {
    throw new DhakSyntaxException('Syntax error: Hyphens are not allowed in the first character of the title and preset.\n');
  }
}
