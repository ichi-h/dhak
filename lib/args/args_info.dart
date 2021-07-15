class ArgsInfo {
  final List<String> args;

  ArgsInfo(this.args);

  bool isOption(int index) {
    return this.args[index].startsWith('-');
  }

  int optionIndex() {
    return this.args.indexWhere((arg) => arg.startsWith('-'));
  }
}
