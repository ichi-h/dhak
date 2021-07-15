import 'dart:io';

class HiddenInput {
  static String readPassword(String message) {
    stdout.write(message);

    stdin.echoMode = false;
    final password = stdin.readLineSync();
    stdin.echoMode = true;

    // Writes new line in order not to print string beside message.
    stdout.write('\n');

    // Receives kill signal
    if (password == null) {
      exit(0);
    }

    return password;
  }
}
