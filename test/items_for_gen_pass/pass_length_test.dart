import 'package:dhak/items_for_gen_pass/pass_length.dart';
import 'package:dhak/util/dhak_exception.dart';
import 'package:test/test.dart';

void main() {
  test('Get passLength value', (() {
    var len = PassLength(20);
    expect(len.value(), equals(20));
  }));

  test('Get passLength value by -f', (() {
    var len = PassLength(5);
    expect(len.value(true), equals(5));
  }));

  test('When passLength is invalid', (() {
    var len = PassLength(1);
    try {
      len.value();
    } on DhakRuntimeException {
      return;
    }
    fail('The invalid passLength value "1" passed test');
  }));
}
