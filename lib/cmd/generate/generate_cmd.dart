import 'package:dhak/cmd/cmd.dart';

class GenerateCmd extends Cmd {
  final String title;
  final String preset;
  final String option;
  final String passPhrase;

  GenerateCmd(this.title, this.preset, this.option, [this.passPhrase = '']);

  @override
  void run() {
    // TODO: implement run
  }
}
