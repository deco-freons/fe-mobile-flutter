class BaseException implements Exception {
  final int statusCode;
  final String message;

  BaseException({required this.statusCode, required this.message});

  @override
  String toString() {
    return '$statusCode $message';
  }
}
