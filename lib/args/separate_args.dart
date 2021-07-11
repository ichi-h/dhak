import 'package:dhak/args/process_args.dart';

class SeparateArgs {
  late final List<String> args;
  late final ProcessArgs _procArgs;

  SeparateArgs(List<String> args) {
    this.args = args;
    this._procArgs = new ProcessArgs(args);
  }

  String title() {
    if (this._procArgs.isHelp()) return '';
    return this.args[0];
  }

  String preset() {
    if (this._procArgs.isHelp()) return '';

    switch(this.args.length) {
      case 1:
        return 'default';
      case 2:
        if (this._procArgs.optionIndex() == -1) return this.args[1];
        return 'default';
      case 3:
        return this.args[1];
      default:
        throw ArgumentError('The length of command-line arguments was too long.');
    }
  }

  String option() {
    if (this._procArgs.isHelp()) return this.args[0];

    var optIndex = this._procArgs.optionIndex();

    if (optIndex == -1) return '';
    return this.args[optIndex];
  }
}
