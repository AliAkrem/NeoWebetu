class CardNotFoundException implements Exception {
  final String message;
  CardNotFoundException(
      [this.message = 'No valid card ID found']);
  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  NetworkException({required this.message, this.statusCode});
  @override
  String toString() =>
      'Network Error: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class DataParsingException implements Exception {
  final String message;
  final dynamic originalError;
  DataParsingException(this.message, [this.originalError]);
  @override
  String toString() =>
      'Data Parsing Error: $message${originalError != null ? ' ($originalError)' : ''}';
}

class SessionExpiredException implements Exception {
  final String message;
  SessionExpiredException(
      [this.message = 'Session has expired. Please login again.']);
  @override
  String toString() => message;
}


class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
  @override
  String toString() => 'Invalid Input: $message';
}
