import 'package:dhak/config/config.dart';
import 'package:test/test.dart';

void main() {
  Config config;

  group('Normal behavior', () {
    test('Get default preset', () {
      config = Config('./config.json');
      var preset = config.getPreset('default');

      var result = {
        'presetName': preset.name,
        'passLen': preset.passLength,
        'symbols': preset.symbols,
        'salt': preset.salt
      };
      var expected = {
        'presetName': 'default',
        'passLen': 20,
        'symbols': ["/", "#", "%", "&", "@", "+", "-", "_"],
        'salt': ''
      };

      expect(result, equals(expected));
    });
  });

  // group('Abnormal behavior', () {});
}
