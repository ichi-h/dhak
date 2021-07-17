class ArgsStatus {
  final List<String> args;

  ArgsStatus(this.args);

  bool isOption(int index) {
    return this.args[index].startsWith('-');
  }

  int optionIndex() {
    return this.args.indexWhere((arg) => arg.startsWith('-'));
  }
}
