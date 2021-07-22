import 'package:dhak/settings/config.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  Config config;

  group('Normal behavior', () {
    test('Get default preset', () {
      config = Config('./.dhakrc');
      var preset = config.getPreset('sample');

      var result = {
        'presetName': preset.name(),
        'passLen': preset.passLength().value(),
        'symbols': preset.symbols().value(),
        'algo': preset.algorithm().value(),
        'cost': preset.cost().value()
      };
      var expected = {
        'presetName': 'sample',
        'passLen': 20,
        'symbols': r'!"#$%&‘()*+,-./:;<=>?@[\]^_`{|}~'.split(''),
        'algo': '2b',
        'cost': 10
      };

      expect(result, equals(expected));
    });
  });

  group('Abnormal behavior', () {
    test('When ~/.dhakrc was not found', () {
      try {
        config = Config('./foo');
      } on DhakRuntimeException {
        return;
      }
      fail('The file "foo" is supposed to exist.');
    });
  });
}
