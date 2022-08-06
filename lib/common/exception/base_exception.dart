class BaseException implements Exception {
  final num statusCode;
  final String message;

  BaseException({
    required this.statusCode,
    required this.message
  });

  @override
  String toString() {
    return '$statusCode $message';
  }
}
