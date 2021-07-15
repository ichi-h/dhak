import 'dart:io';

import 'package:dhak/config/config.dart';
import 'package:dhak/config/preset.dart';
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
      var preset = Preset('default', config.doc());

      var result = {
        'presetName': preset.name(),
        'passLen': preset.passLength(),
        'symbols': preset.symbols(),
        'salt': preset.salt()
      };
      var expected = {
        'presetName': 'default',
        'passLen': 20,
        'symbols': ["/", "#", "%", "&", "@", "+", "-", "_"],
        'salt': ''
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
