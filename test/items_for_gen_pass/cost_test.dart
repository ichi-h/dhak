import 'package:dhak/items_for_gen_pass/cost.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  test('Get cost value', (() {
    var cost = Cost('4');
    expect(cost.value(), equals('04'));
  }));

  test('When cost is invalid', (() {
    var cost = Cost('1');
    try {
      cost.value();
    } on DhakRuntimeException {
      return;
    }
    fail('The invalid cost value "1" passed test');
  }));
}
