import 'dart:io';

import 'package:dhak/config/config.dart';
import 'package:test/test.dart';

void main() {
  Config config;

  group('Normal behavior', () {
    tearDownAll(() {
      var file = File('./tool/.dhakrc');
      file.deleteSync();
    });

    test('Get default preset', () {
      config = Config('./.dhakrc');
      var preset = config.getPreset('default', 0);

      var algo = preset.algorithm().value();
      var cost = preset.cost().value();
      var result = {
        'presetName': preset.name(),
        'passLen': preset.passLength().value(),
        'symbols': preset.symbols().value(),
        'salt': '\$$algo\$$cost\$${preset.salt()}'
      };
      var expected = {
        'presetName': 'default',
        'passLen': 20,
        'symbols': '!"#\$%&‘()*+,-./:;<=>?@[\\}^_`{|}~'.split(''),
        'salt': '\$2b\$10\$pbCZ/hEjzP3IO4Z/bTaDBV'
      };

      expect(result, equals(expected));
    });

    test('When .dhakrc was not found', () {
      config = Config('./tool/.dhakrc');

      var file = File('./tool/.dhakrc');
      expect(file.existsSync(), isTrue);
    });
  });

  // group('Abnormal behavior', () {});
}
