import 'dart:io';

import 'package:dhak/args/separate_args.dart';
import 'package:dhak/cmd/command_routing.dart';
import 'package:dhak/util/dhak_exception.dart';

void main(List<String> arguments) {
  if (arguments.length == 0) {
    arguments = ['', '', '--help'];
  }

  final sepArgs = SeparateArgs(arguments);
  var title, preset, options;
  try {
    title = sepArgs.title();
    preset = sepArgs.preset();
    options = sepArgs.options();
  } on DhakArgsException catch(e) {
    print(e.message);
    exit(1);
  }

  CommandRouting(title, preset, options).run();
}
