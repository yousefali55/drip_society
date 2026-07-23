import 'package:dio/dio.dart';

class ApiError {
  static String extractErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        return data['message'];
      }

      if (data['error'] != null &&
          data['error'] is Map &&
          data['error']['message'] != null) {
        return data['error']['message'];
      }
    }

    return e.message ?? "Something went wrong";
  }
}