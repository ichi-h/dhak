class SeparateArgs {
  final List<String> args;

  SeparateArgs(this.args);

  String title() {
    if (this._isHelp()) return '';
    return this.args[0];
  }

  String preset() {
    if (this._isHelp()) return '';

    var optIndex = _optionIndex();

    switch(this.args.length) {
      case 1:
        return 'default';
      case 2:
        if (optIndex == -1) return this.args[1];
        return 'default';
      case 3:
        return this.args[1];
      default:
        throw ArgumentError('The length of command-line arguments was too long.');
    }
  }

  String option() {
    if (this._isHelp()) return this.args[0];

    var optIndex = this._optionIndex();

    if (optIndex == -1) return '';
    return this.args[optIndex];
  }

  bool _isHelp() {
    if (this.args.length == 1 && this._isOptionHelp(0)) {
      return true;
    }
    return false;
  }

  bool _isOptionHelp(int index) {
    return this.args[index] == '-h' || this.args[index] == '--help';
  }

  int _optionIndex() {
    return this.args.indexWhere(
      (arg) => arg.startsWith('-')
    );
  }
}
