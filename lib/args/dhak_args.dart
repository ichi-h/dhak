class DhakArgs {
  late final String title;
  late final String preset;
  late final String option;

  DhakArgs(List<String> args) {
    this.title = args[0];
    this.preset = args[1];
    this.option = args[2];
  }
}
