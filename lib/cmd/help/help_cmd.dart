import 'package:dhak/cmd/cmd.dart';

class HelpCmd extends Cmd {
  @override
  void run() {
    print(
        '''Usage: dhak [-h, --help] [-v, --version] <title> (<preset>) [option]

-h, --help:
    Display the help of dhak.
-v, --version:
    Display the version of dhak.
title:
    The name of the service.
preset:
    The pre-prepared setting for password generation (you can add a preset in ~/.dhakrc).
    If you omit this, the value will be "default".
option:
    Specify additional functions as needed.
    dhak will use the optional settings in preference to the preset ones.
    -d, --display
        Display the password in the terminal.
    -f, --force
        Generate a non-secure password forcibly, such as a password whose length is less than 8 or a password which has only lower-case.
    --len=
        Set a password length. If it is less than 8, you cannot generate the password basically.
    --sym=
        Set symbols used the password generation.
    --algo=
        Set an algorithm of BCrypt. You can use "2", "2a", "2y" and "2b (default)".
    --cost=
        Set a cost of BCrypt. It must be between 4 and 31. The actual rounds of stretching are 2^n.
''');
  }
}
