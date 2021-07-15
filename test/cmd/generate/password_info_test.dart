import 'package:dhak/cmd/generate/password_info.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    PasswordInfo info;

    test('Has symbols', () {
      var password = r"PQqQaZ5I'mmw6.\h`\a;";
      info = PasswordInfo(password);
      expect(info.hasSymbols(), equals(true));
    });

    test('Not have symbols', () {
      var password = 'j8QfVGvzstJJShiAfx8o';
      info = PasswordInfo(password);
      expect(info.hasSymbols(), equals(false));
    });

    test('Has lower case, upper case and number', () {
      var password = 'L2ydGSzxay7pLG6BJK7S';
      info = PasswordInfo(password);
      expect(info.isSecure(), equals(true));
    });

    test('Not have lower case, upper case and number', () {
      var password = 'l2ydgszxay7plg6bjk7s'; // not have upper case letter
      info = PasswordInfo(password);
      expect(info.isSecure(), equals(false));
    });
  });
}
