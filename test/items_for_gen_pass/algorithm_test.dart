import 'package:dhak/items_for_gen_pass/algorithm.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  test('Get algo value', (() {
    var algo = Algorithm('2b');
    expect(algo.value(), equals('2b'));
  }));

  test('When algo is invalid', (() {
    var algo = Algorithm('2d');
    try {
      algo.value();
    } on DhakRuntimeException {
      return;
    }
    fail('The invalid algorithm value "2d" passed test');
  }));
}
