class Preset {
  late final String _name;
  late final int _passLength;
  late final List<String> _symbols;
  late String _salt;

  Preset(this._name, this._passLength, this._symbols, this._salt);

  String name() => this._name;

  int passLength() => this._passLength;

  List<String> symbols() => this._symbols;

  String salt() => this._salt;

  void setSalt(String salt) {
    this._salt = salt;
  }
}
