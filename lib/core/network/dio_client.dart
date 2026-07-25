import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_constants.dart';
import 'package:drip_society/core/utils/perfs_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PerfsHelper.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // print('Request URL: ${options.uri.toString()}');
          // print('Request Method: ${options.method}');
          // print('Request Headers: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // print('Status Code: ${response.statusCode}');
          // print('Response Headers: ${response.headers.map}');
          // print('Raw Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // print('Exception Type: ${e.type}');
          // print('Exception Message: ${e.message}');
          // print('StackTrace: ${e.stackTrace}');
          // print('Response Data: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
