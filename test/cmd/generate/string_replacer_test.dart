import 'package:dhak/cmd/generate/random_replacer.dart';
import 'package:test/test.dart';

void main() {
  group('Normal behavior', () {
    test('', () {
      var password = "mq55vn43JnIQSQnh3YJL";
      var symbols = ['/', '#', '%', '@', '+', '-', '_'];

      var rr = RandomReplacer(password);
      var processed = rr.replaceBy(symbols);

      if (password == processed) {
        fail('String was not replaced.');
      }
    });
  });
}
