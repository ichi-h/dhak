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
      var preset = config.getPreset('default');

      var result = {
        'presetName': preset.name(),
        'passLen': preset.passLength().value(),
        'symbols': preset.symbols().value(),
        'algo': preset.algorithm().value(),
        'cost': preset.cost().value()
      };
      var expected = {
        'presetName': 'default',
        'passLen': 20,
        'symbols': '!"#\$%&‘()*+,-./:;<=>?@[\\}^_`{|}~'.split(''),
        'algo': '2b',
        'cost': '10'
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
