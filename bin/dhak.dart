import 'package:dhak/args/syntax_checker.dart';
import 'package:dhak/cmd/command_routing.dart';

void main(List<String> arguments) {
  if (arguments.length == 0) {
    arguments = ['', '', '--help'];
  }

  final checker = SyntaxChecker(arguments);

  final args = checker.checkedArgs();

  CommandRouting(args[0], args[1], args[2]).run();
  // args[0]: title
  // args[1]: preset
  // args[2]: option
}
