import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/cmd/generate/generate_cmd.dart';
import 'package:dhak/cmd/help/help_cmd.dart';
import 'package:dhak/cmd/version/version_cmd.dart';
import 'package:dhak/util/dhak_exception.dart';

class CommandRouting extends Cmd {
  late final String title;
  late final String preset;
  late final String option;

  CommandRouting(this.title, this.preset, this.option);

  void run() {
    try {
      this._runCmd();
    } on DhakArgsException catch (e) {
      print(e.message);
      CommandRouting('', '', '--help').run();
    } on DhakRuntimeException catch (e) {
      print(e.message);
    }
  }

  void _runCmd() {
    final Cmd cmd;

    if (this.title == '') {
      cmd = this._optionCommand();
    } else {
      cmd = GenerateCmd(this.title, this.preset, this.option);
    }

    cmd.run();
  }

  Cmd _optionCommand() {
    switch (this.option) {
      case '-h':
      case '--help':
        return HelpCmd();

      case '-v':
      case '--version':
        return VersionCmd();

      default:
        throw DhakArgsException(
            'Runtime error: There is no command corresponding to option "$option" in dhak.');
    }
  }
}
