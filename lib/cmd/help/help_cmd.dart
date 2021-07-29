import 'package:dhak/cmd/cmd.dart';

class HelpCmd extends Cmd {
  @override
  void run() {
    print(
        r'''Usage: dhak [-h, --help] [-v, --version] <title> (<preset>) [options]

Command:
    -h, --help
        Display the help of Dhak.
    -v, --version
        Display the version of Dhak.
Title:
    The name of the service.
Preset:
    The pre-prepared setting for password generation (you can add a preset to ~/.dhakrc).
Options:
    Specify additional functions as needed.
    Dhak will use the optional settings in preference to the preset ones.
    The following values of the options mean the default values in this app. If you omit a option, Dhak will use them.
    -d, --display
        Display the password in the terminal.
    -f, --force (deprecated)
        Forcibly generate a password which may be insecure, such as a password whose length is less than 12 or a password which has only lower-case.
    --len=20
        Set a password length. If it is less than 12, you cannot generate the password basically.
    --sym=!"#$%&‘()*+,-./:;<=>?@[\]^_`{|}~
        Set symbols used the password generation.
    --algo=2b
        Set an algorithm of BCrypt. You can use "2", "2a", "2y" and "2b".
    --cost=10
        Set a cost of BCrypt. It must be between 4 and 31. The actual rounds of stretching are 2^n.

For more details, see https://ippee.github.io/dhak_docs/
''');
  }
}
