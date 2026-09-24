import 'package:dio/dio.dart';

enum AppErrorType { network, timeout, notFound, validation, server, unknown }

class AppException implements Exception {
  final AppErrorType errorType;
  final String message;

  const AppException({required this.errorType, required this.message});

  @override
  String toString() {
    return 'AppException is (type: $errorType , message: $message)';
  }
}

class ApiErrorHandler {
  const ApiErrorHandler._();
  static AppException handle(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const AppException(
          errorType: AppErrorType.timeout,
          message: 'Connection timeout. Please try again.',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);
      case DioExceptionType.cancel:
        return const AppException(
          errorType: AppErrorType.unknown,
          message: 'Request was cancelled.',
        );
      case DioExceptionType.badCertificate:
        return const AppException(
          errorType: AppErrorType.network,
          message: 'Secure connection could not be established.',
        );

      case DioExceptionType.unknown:
        return const AppException(
          errorType: AppErrorType.unknown,
          message: 'Something went wrong. Please try again.',
        );
    }
  }
}

AppException _handleBadResponse(DioException exception) {
  final statusCode = exception.response?.statusCode;
  switch (statusCode) {
    case 404:
      return const AppException(
        errorType: AppErrorType.notFound,
        message: 'The requested resource was not found.',
      );

    case 422:
      return AppException(
        errorType: AppErrorType.validation,
        message: _extractMessage(exception) ?? 'Validation failed.',
      );

    case 500:
    case 502:
    case 503:
    case 504:
      return const AppException(
        errorType: AppErrorType.server,
        message: 'Server error. Please try again later.',
      );

    default:
      return AppException(
        errorType: AppErrorType.unknown,
        message:
            _extractMessage(exception) ??
            'Something went wrong. Please try again.',
      );
  }
}

String? _extractMessage(DioException exception) {
  final data = exception.response?.data;

  if (data is Map<String, dynamic>) {
    final message = data['message'];

    if (message is String && message.isNotEmpty) {
      return message;
    }
  }

  return null;
}
