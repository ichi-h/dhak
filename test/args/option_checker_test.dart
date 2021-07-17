import 'package:dhak/args/option_checker.dart';
import 'package:test/test.dart';

void main() {
  test('passLenIsSafety() is true', () {
    var result = OptionChecker.passLenIsSafety(20, false);
    expect(result, isTrue);
  });

  test('passLenIsSafety() is true by -f', () {
    var result = OptionChecker.passLenIsSafety(5, true);
    expect(result, isTrue);
  });

  test('passLenIsSafety() is false', () {
    var result = OptionChecker.passLenIsSafety(3, false);
    expect(result, isFalse);
  });

  test('canParseInt() is true', () {
    var result = OptionChecker.canParseInt('10');
    expect(result, isTrue);
  });

  test('canParseInt() is false', () {
    var result = OptionChecker.canParseInt('a');
    expect(result, isFalse);
  });

  test('isValidAlgo() is true', () {
    var result = OptionChecker.isValidAlgo('2b');
    expect(result, isTrue);
  });

  test('isValidAlgo() is false', () {
    var result = OptionChecker.isValidAlgo('2d');
    expect(result, isFalse);
  });

  test('isValidCost() is true', () {
    var result = OptionChecker.isValidCost(10);
    expect(result, isTrue);
  });

  test('isValidCost() is false', () {
    var result = OptionChecker.isValidCost(99);
    expect(result, isFalse);
  });
}