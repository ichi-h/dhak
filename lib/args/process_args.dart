class ProcessArgs {
  final List<String> args;
  ProcessArgs(this.args);

  bool isOption(int index) {
    return this.args[index].startsWith('-');
  }

  bool isOptionHelp(int index) {
    return this.args[index] == '-h' || this.args[index] == '--help';
  }

  int optionIndex() {
    return this.args.indexWhere(
            (arg) => arg.startsWith('-')
    );
  }

  bool isHelp() {
    if (this.args.length == 1 && this.isOptionHelp(0)) {
      return true;
    }
    return false;
  }
}
