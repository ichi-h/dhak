import 'package:dhak/cmd/generate/password_status.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    PasswordStatus info;

    test('Has symbols', () {
      var password = r"PQqQaZ5I'mmw6.\h`\a;";
      info = PasswordStatus(password);
      expect(info.hasSymbols(), isTrue);
    });

    test('Not have symbols', () {
      var password = 'j8QfVGvzstJJShiAfx8o';
      info = PasswordStatus(password);
      expect(info.hasSymbols(), isFalse);
    });

    test('Has lower case, upper case and number', () {
      var password = 'L2ydGSzxay7pLG6BJK7S';
      info = PasswordStatus(password);
      expect(info.isSecure(), isTrue);
    });

    test('Not have lower case, upper case and number', () {
      var password = 'l2ydgszxay7plg6bjk7s'; // not have upper case letter
      info = PasswordStatus(password);
      expect(info.isSecure(), isFalse);
    });
  });
}
