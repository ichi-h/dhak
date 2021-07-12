import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/dhak_exception.dart';

class CommandRouting extends Cmd {
  late final String title;
  late final String preset;
  late final String option;

  CommandRouting(this.title, this.preset, this.option);

  void run() {
    try {
      this._actualRun();
    } on DhakArgsException catch (e) {
      print(e.message);
      CommandRouting('', '', '--help').run();
    } on DhakRuntimeException catch (e) {
      print(e.message);
    }
  }

  void _actualRun() {
    if (this.title == '') {
      this._runOptionCommand();
      return;
    }

    // TODO: implement process of generate password
  }

  void _runOptionCommand() {
    switch (this.option) {
      case '-h':
      case '--help':
        // TODO: implement help
        break;

      case '-v':
      case '--version':
        // TODO: implement version
        break;

      default:
        throw DhakArgsException(
            'Runtime error: There is no command corresponding to option "$option" in dhak.');
    }
  }
}
