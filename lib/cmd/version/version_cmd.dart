import 'package:dhak/cmd/cmd.dart';
import 'package:dhak/util/global_const.dart';

class VersionCmd extends Cmd {
  @override
  void run() {
    var version = GlobalConst.VERSION;
    print('dhak version $version');
  }
}
