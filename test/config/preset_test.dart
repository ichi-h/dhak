import 'package:dhak/config/preset.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    var preset = Preset('default', 20, ['%', '5'], r'$2b$10$gEFq.t64qSdMqKw3NHR0YO');

    test('Get symbols', () {
      var symbols = preset.symbols();
      expect(symbols, equals(['%']));
    });
  });
}
