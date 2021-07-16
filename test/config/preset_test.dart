import 'package:dhak/config/preset.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    var preset = Preset('default', 20, ['%', '5'], r'$2b$10$gEFq.t64qSdMqKw3NHR0YO');

    test('Get preset name', () {
      var name = preset.name();
      expect(name, equals('default'));
    });

    test('Get length of generated passwords', () {
      var len = preset.passLength();
      expect(len, equals(20));
    });

    test('Get preset name', () {
      var symbols = preset.symbols();
      expect(symbols, equals(['%']));
    });

    test('Get preset name', () {
      var salt = preset.salt();
      expect(salt, equals(r'$2b$10$gEFq.t64qSdMqKw3NHR0YO'));
    });
  });

  group('Abnormal behavior', () {
    test('Invalid preset name', () {
      Preset preset = Preset('-default', 0, [''], '');
      try {
        preset.name();
      } on DhakRuntimeException {
        return;
      }
      fail('The invalid name passes the test.');
    });

    test('Invalid passLength', () {
      Preset preset = Preset('', 0, [''], '');
      try {
        preset.passLength();
      } on DhakRuntimeException {
        return;
      }
      fail('The invalid passLength passes the test.');
    });

    group('Salt test', () {
      Preset preset;

      test('Invalid algorithm', () {
        preset = Preset('', 0, [''], r'$2c$10$gEFq.t64qSdMqKw3NHR0YO');
        try {
          preset.salt();
        } on DhakRuntimeException {
          return;
        }
        fail('The invalid algorithm passes the test.');
      });

      test('Invalid stretching length', () {
        preset = Preset('', 0, [''], r'$2b$99$gEFq.t64qSdMqKw3NHR0YO');
        try {
          preset.salt();
        } on DhakRuntimeException {
          return;
        }
        fail('The invalid stretching length passes the test.');
      });

      test('Invalid salt', () {
        preset = Preset('', 0, [''], r'$2b$10$gEFq.t64qSdMqKw3NH');
        try {
          preset.salt();
        } on DhakRuntimeException {
          return;
        }
        fail('The invalid salt passes the test.');
      });
    });
  });
}
