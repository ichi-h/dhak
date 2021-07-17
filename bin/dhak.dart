import 'package:dhak/args/separate_args.dart';
import 'package:dhak/cmd/command_routing.dart';

void main(List<String> arguments) {
  if (arguments.length == 0) {
    arguments = ['', '', '--help'];
  }

  final sepArgs = SeparateArgs(arguments);
  final title = sepArgs.title();
  final preset = sepArgs.preset();
  final options = sepArgs.options();

  CommandRouting(title, preset, options).run();
}
