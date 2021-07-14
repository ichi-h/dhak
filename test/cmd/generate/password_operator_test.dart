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

    test('Has symbols', () {
      var password = r"PQqQaZ5I'mmw6.\h`\a;";
      operator = PasswordOperator(password);
      expect(operator.hasSymbols(), equals(true));
    });

    test('Not have symbols', () {
      var password = 'j8QfVGvzstJJShiAfx8o';
      operator = PasswordOperator(password);
      expect(operator.hasSymbols(), equals(false));
    });

    test('Has lower case, upper case and number', () {
      var password = 'L2ydGSzxay7pLG6BJK7S';
      operator = PasswordOperator(password);
      expect(operator.isSecure(), equals(true));
    });

    test('Not have lower case, upper case and number', () {
      var password = 'l2ydgszxay7plg6bjk7s'; // not have upper case letter
      operator = PasswordOperator(password);
      expect(operator.isSecure(), equals(false));
    });
  });
}
