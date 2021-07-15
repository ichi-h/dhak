import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/util/global_const.dart';

class VersionCmd extends Cmd {
  @override
  void run() {
    print('dhak version ${GlobalConst.VERSION}');
  }
}
