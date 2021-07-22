import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:dhak/settings/default_preset.dart';
import 'package:dhak/settings/preset.dart';
import 'package:dhak/util/color_print.dart';
import 'package:dhak/util/dhak_exception.dart';

class Config {
  late Map<String, dynamic> _doc;

  Config(String path) {
    var file = File(path);
    var contents = file.readAsStringSync();
    this._doc = json.decode(contents);

    var text =
        "WARNING: It seems to use your .dhakrc setting, but you SHOULDN'T use it in terms of information leak.";
    colorPrint(text, Color.YELLOW);
  }

  Preset getPreset(String presetName) {
    final preset = this._doc['presets'][presetName];
    if (preset == null) {
      throw DhakRuntimeException(
          'Runtime error: The preset name "$presetName" was not found.');
    }

    String? passLength = preset['password_length'];
    passLength ??= DefaultPreset.passLength;

    String? symbols = preset['symbols'];
    symbols ??= DefaultPreset.symbols;

    String? algo = preset['algorithm'];
    String? cost = preset['cost'];
    algo ??= DefaultPreset.algo;
    cost ??= DefaultPreset.cost;

    return Preset(presetName, passLength, symbols, algo, cost);
  }
}
