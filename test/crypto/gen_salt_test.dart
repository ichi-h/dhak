import 'package:dhak/crypto/gen_salt.dart';
import 'package:test/test.dart';

void main() {
  test('When I input the same value, will I get the same salt?', () {
    var result = ['', ''];
    result = result.map((e) => GenSalt.fromHashCode(0)).toList();
    expect(result[0], equals(result[1]));
  });
}
