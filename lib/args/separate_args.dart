import 'package:dhak/util/dhak_exception.dart' show DhakArgsException;

enum _Target { title, preset }

class SeparateArgs {
  late final List<String> args;

  SeparateArgs(List<String> args) {
    this.args = args;
  }

  String title() => this._getTitleOrPreset(_Target.title);

  String preset() => this._getTitleOrPreset(_Target.preset);

  List<String> options() {
    var index = this._optionIndex();
    if (index == -1) {
      return [''];
    }

    List<String> backArgs = [];
    for (var i = index; i < this.args.length; i++) {
      if (!this.args[i].startsWith('-')) {
        throw DhakArgsException(
            'Syntax error: The argument ${this.args[i]} is not a option.');
      }
      backArgs.add(this.args[i]);
    }

    return backArgs;
  }

  String _getTitleOrPreset(_Target target) {
    var frontArgs = [];
    var index = this._optionIndex();
    if (index == -1) {
      frontArgs = this.args;
    }

    for (var i = 0; i < index; i++) frontArgs.add(this.args[i]);

    switch (frontArgs.length) {
      case 0:
        return '';

      case 1:
        if (target == _Target.title) return frontArgs[0];
        return 'default';

      case 2:
        if (target == _Target.title) return frontArgs[0];
        return frontArgs[1];

      default:
        var unknownArgs = [];
        for (var i = 2; i < frontArgs.length; i++) {
          unknownArgs.add(frontArgs[i]);
        }

        throw DhakArgsException(
            'Syntax error: $unknownArgs are unknown arguments.');
    }
  }

  int _optionIndex() {
    return this.args.indexWhere((arg) => arg.startsWith('-'));
  }
}
