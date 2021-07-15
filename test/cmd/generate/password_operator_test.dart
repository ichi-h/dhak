import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    PasswordOperator operator;

    test('Replace char of password with symbols', () {
      var password = 'mq55vn43JnIQSQnh3YJL';
      var symbols = ['/', '#', '%', '@', '+', '-', '_'];

      var result = ['', ''];
      for (var i = 0; i < 2; i++) {
        operator = PasswordOperator(password);
        result[i] = operator.replaceAtRandomWith(symbols);
      }

      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.');
      }

      if (result[0] == password) {
        fail('Password was not replaced.');
      }
    });

    test('Replace symbols with char', () {
      var password = r"PQqQaZ5I'mmw6.\h`\a;";
      operator = PasswordOperator(password);

      var result = operator.replaceSymbols();

      if (result == password) {
        fail('Password was not replaced.');
      }
    });
  });
}
