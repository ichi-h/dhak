class DhakSyntaxException implements Exception {
  final String message;
  DhakSyntaxException(this.message);
}

class DhakRuntimeException implements Exception {
  final String message;
  DhakRuntimeException(this.message);
}
