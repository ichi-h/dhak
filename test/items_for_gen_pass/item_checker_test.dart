import 'package:dhak/items_for_gen_pass/item_checker.dart';
import 'package:test/test.dart';

void main() {
  test('canParseInt() is true', () {
    var result = ItemChecker.canParseInt('10');
    expect(result, isTrue);
  });

  test('canParseInt() is false', () {
    var result = ItemChecker.canParseInt('a');
    expect(result, isFalse);
  });
}
