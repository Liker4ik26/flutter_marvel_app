import 'package:dio/dio.dart';

abstract class CustomDioError {
  CustomDioError._();

  static Exception handleError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RequestTimeoutException();
      case DioExceptionType.badResponse:
        if (dioException.response?.statusCode == 500) {
          return ServerErrorException('Internal Server Error');
        } else {
          return ServerErrorException(
            'Server error with status code: '
            '${dioException.response?.statusCode}',
          );
        }
      case DioExceptionType.unknown:
      default:
        return UnknownErrorException();
    }
  }

  static String formatErrorMessage(Exception error) {
    if (error is NoInternetException) {
      return '❌ ${error.message}';
    } else if (error is RequestTimeoutException) {
      return '⏳ ${error.message}';
    } else if (error is ServerErrorException) {
      return '⚠️ ${error.message}';
    } else if (error is UnknownErrorException) {
      return '❓ ${error.message}';
    }
    return '❗ An unexpected error occurred.';
  }
}

class NoInternetException implements Exception {
  NoInternetException([this.message = 'No internet connection.']);

  final String message;
}

class RequestTimeoutException implements Exception {
  RequestTimeoutException([this.message = 'Request timed out.']);

  final String message;
}

class ServerErrorException implements Exception {
  ServerErrorException([this.message = 'Server error occurred.']);

  final String message;
}

class UnknownErrorException implements Exception {
  UnknownErrorException([this.message = 'An unknown error occurred.']);

  final String message;
}
