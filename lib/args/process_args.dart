class ProcessArgs {
  final List<String> args;

  ProcessArgs(this.args);

  bool isOption(int index) {
    return this.args[index].startsWith('-');
  }

  int optionIndex() {
    return this.args.indexWhere((arg) => arg.startsWith('-'));
  }
}
