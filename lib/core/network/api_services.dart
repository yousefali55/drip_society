import 'package:dio/dio.dart';
import 'package:drip_society/core/network/dio_client.dart';

class ApiServices {
  final DioClient _dioClient = DioClient();
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: body);
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> delete(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}
