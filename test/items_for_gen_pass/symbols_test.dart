import 'package:dhak/items_for_gen_pass/symbols.dart';
import 'package:test/test.dart';

void main() {
  test('Get symbols value', (() {
    var sym = Symbols(['#', '&', 'a']);
    expect(sym.value(), equals(['#', '&']));
  }));

  test('When symbols are empty', (() {
    var sym = Symbols([]);
    expect(sym.value(), equals([]));
  }));
}
