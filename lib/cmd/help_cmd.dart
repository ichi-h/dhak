import 'package:dhak/cmd/cmd.dart';

class HelpCmd extends Cmd {
  @override
  void run() {
    print(
        '''Usage: dhak [-v, --version] [-h, --help] <title> (<preset>) [option]

dhak combines your original passphrase with the name of the service that
requires a password, hashes it, and uses the value as the new password.
The generated password will be copied to the clipboard.

The syntax of dhak basically consists of three parts: title, preset, and
option.

title:
  The name of the service.
preset:
  The pre-prepared setting for password generation (you can add your own
  presets in ~/.dhakrc).
  If it is omitted, the value will be "default".
option:
  Specify additional functions as needed.
    -d: Display the password in the terminal.
''');
  }
}
