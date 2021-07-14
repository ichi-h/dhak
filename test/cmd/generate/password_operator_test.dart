import 'package:dhak/cmd/generate/password_operator.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    test('Replace char of password by symbols', () {
      var password = "mq55vn43JnIQSQnh3YJL";
      var symbols = ['/', '#', '%', '@', '+', '-', '_'];

      var result = ['', ''];
      for (var i = 0; i < 2; i++) {
        var rr = PasswordOperator(password);
        result[i] = rr.replaceAtRandomWith(symbols);
      }

      if (result[0] != result[1]) {
        fail(
            'Different passwords have been generated under the same conditions.');
      }

      if (result[0] == password) {
        fail('Password was not replaced.');
      }
    });
  });
}
