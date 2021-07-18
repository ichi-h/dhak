import 'package:console/console.dart';
import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/cmd/generate/generate_cmd.dart';
import 'package:dhak/cmd/help/help_cmd.dart';
import 'package:dhak/cmd/version/version_cmd.dart';
import 'package:dhak/util/color_print.dart';
import 'package:dhak/util/dhak_exception.dart';

class CommandRouting extends Cmd {
  late final String title;
  late final String preset;
  late final List<String> options;

  CommandRouting(this.title, this.preset, this.options);

  void run() {
    try {
      this._runCmd();
    } on DhakArgsException catch (e) {
      colorPrint(e.message, Color.RED);
      CommandRouting('', '', ['--help']).run();
    } on DhakRuntimeException catch (e) {
      colorPrint(e.message, Color.RED);
    }
  }

  void _runCmd() {
    final Cmd cmd;

    if (this.title == '') {
      cmd = this._optionCommand();
    } else {
      cmd = GenerateCmd(this.title, this.preset, this.options);
    }

    cmd.run();
  }

  Cmd _optionCommand() {
    switch (this.options[0]) {
      case '-h':
      case '--help':
        return HelpCmd();

      case '-v':
      case '--version':
        return VersionCmd();

      default:
        throw DhakArgsException(
            'Command error: The command "${this.options[0]}" does not exist.\n');
    }
  }
}
