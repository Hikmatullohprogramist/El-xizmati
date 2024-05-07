class NetworkException implements Exception {
  final String message;
  final int statusCode;

  NetworkException({required this.message, required this.statusCode});

  @override
  String toString() {
    return "ApiException: $message (Status code: $statusCode)";
  }
}
