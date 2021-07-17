class Options {
  final List<String> _options;

  Options(this._options);

  bool haveForce() => true;

  bool haveDisplay() => true;

  int passLength() => 0;

  String algorithm() => '';

  String cost() => '';

  List<String> toList() => this._options;
}
