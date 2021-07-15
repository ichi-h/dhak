class Preset {
  final String name;
  final int passLength;
  final List<String> symbols;
  final String salt;

  Preset(this.name, this.passLength, this.symbols, this.salt);
}
