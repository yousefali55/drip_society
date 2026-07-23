import 'package:dio/dio.dart';

class ApiExceptions {
  static String getMessage(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ?? 'Server error';
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Unexpected error';
    }
  }
}
