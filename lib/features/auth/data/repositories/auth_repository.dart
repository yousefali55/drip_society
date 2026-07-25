import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_constants.dart';
import 'package:drip_society/core/network/dio_client.dart';
import 'package:drip_society/features/auth/data/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository({Dio? dio}) : _dio = dio ?? DioClient().dio;

  static const String _tokenKey = 'auth_token';
  static const String _customerKey = 'auth_customer';

  final Dio _dio;

  static String normalizeInput(String input) {
    return input.replaceAll(RegExp(r'[\u200B-\u200D\u2060\uFEFF]'), '').trim();
  }

  Future<AuthResult> login({required String email, required String password}) async {
    final normalizedEmail = normalizeInput(email);
    final normalizedPassword = normalizeInput(password);
    final candidateBodies = [
      {'email': normalizedEmail, 'password': normalizedPassword},
      {'userName': normalizedEmail, 'password': normalizedPassword},
      {'username': normalizedEmail, 'password': normalizedPassword},
      {'Email': normalizedEmail, 'Password': normalizedPassword},
      {'UserName': normalizedEmail, 'Password': normalizedPassword},
    ];

    for (final body in candidateBodies) {
      try {
        // final jsonBody = jsonEncode(body);
        // final bodyBytes = utf8.encode(jsonBody);
        final options = Options(
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
          },
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        );

        // print('Complete request URL: ${ApiConstants.baseUrl}/Customers/login');
        // print('Complete request method: POST');
        // print('Complete request headers: ${options.headers}');
        // print('Complete request body: $jsonBody');
        // print('Complete request body bytes: $bodyBytes');

        final response = await _dio.post('${ApiConstants.baseUrl}/Customers/login', data: body, options: options);
        // print('Complete response status: ${response.statusCode}');
        // print('Complete response body: ${response.data}');

        final payload = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : jsonDecode(response.data.toString()) as Map<String, dynamic>;

        final token = _extractToken(payload);
        final customer = _extractCustomer(payload, email: normalizedEmail);

        if (token != null && customer != null) {
          await saveToken(token);
          await saveCustomer(customer);
          return AuthResult.success(token: token, customer: customer, message: 'Welcome back!');
        }
      } on DioException catch (error) {
        // print('Complete DioException: ${error.type}');
        // print('Complete DioException message: ${error.message}');
        // print('Complete DioException response body: ${error.response?.data}');
        // print('Complete DioException response headers: ${error.response?.headers.map}');
        final message = _extractErrorMessage(error);
        if (!_looksLikePayloadMismatch(message)) {
          return AuthResult.failure(message);
        }
      } catch (error) {
        print('Unexpected login error: $error');
        return AuthResult.failure('Unexpected error. Please try again.');
      }
    }

    return AuthResult.failure('Unable to complete sign in. Please try again.');
  }

  Future<AuthResult> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String city,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/Customers/register',
        data: {
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
          'email': email.trim(),
          'phoneNumber': phoneNumber.trim(),
          'password': password,
          'city': city.trim(),
        },
      );

      final payload = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : jsonDecode(response.data.toString()) as Map<String, dynamic>;

      final token = _extractToken(payload);
      final customer = _extractCustomer(
        payload,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: email.trim(),
        phoneNumber: phoneNumber.trim(),
        city: city.trim(),
      );

      if (customer == null) {
        return AuthResult.failure('Unable to create your account. Please try again.');
      }

      if (token != null) {
        await saveToken(token);
      }
      await saveCustomer(customer);

      return AuthResult.success(token: token, customer: customer, message: 'Account created successfully!');
    } on DioException catch (error) {
      return AuthResult.failure(_extractErrorMessage(error));
    } catch (_) {
      return AuthResult.failure('Unexpected error. Please try again.');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveCustomer(CustomerModel customer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_customerKey, jsonEncode(customer.toJson()));
  }

  Future<CustomerModel?> getCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_customerKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return CustomerModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_customerKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<AuthSession?> loadSession() async {
    final token = await getToken();
    final customer = await getCustomer();
    if (token == null || token.isEmpty || customer == null) {
      return null;
    }
    return AuthSession(token: token, customer: customer);
  }

  String _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final flattened = <String>[];
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        for (final entry in errors.entries) {
          final value = entry.value;
          if (value is List) {
            flattened.addAll(value.whereType<String>());
          } else if (value is String) {
            flattened.add(value);
          }
        }
      }

      if (flattened.isNotEmpty) {
        return flattened.join(' ');
      }

      return (data['message'] ?? data['error'] ?? data['title'] ?? 'Authentication failed').toString();
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return error.message ?? 'Authentication failed';
  }

  bool _looksLikePayloadMismatch(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('username') ||
        normalized.contains('email') ||
        normalized.contains('required') ||
        normalized.contains('validation') ||
        normalized.contains('modelstate');
  }

  String? _extractToken(Map<String, dynamic> payload) {
    if (payload['token'] != null) return payload['token'].toString();
    if (payload['accessToken'] != null) return payload['accessToken'].toString();
    if (payload['jwt'] != null) return payload['jwt'].toString();
    if (payload['data'] is Map<String, dynamic>) {
      final data = payload['data'] as Map<String, dynamic>;
      return _extractToken(data);
    }
    return null;
  }

  CustomerModel? _extractCustomer(
    Map<String, dynamic> payload, {
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
  }) {
    final directCustomer = payload['customer'];
    if (directCustomer is Map<String, dynamic>) {
      return CustomerModel.fromJson(directCustomer);
    }

    final user = payload['user'];
    if (user is Map<String, dynamic>) {
      return CustomerModel.fromJson(user);
    }

    final data = payload['data'];
    if (data is Map<String, dynamic>) {
      if (data['customer'] is Map<String, dynamic>) {
        return CustomerModel.fromJson(data['customer'] as Map<String, dynamic>);
      }
      if (data['user'] is Map<String, dynamic>) {
        return CustomerModel.fromJson(data['user'] as Map<String, dynamic>);
      }
    }

    final fallbackEmail = email ?? payload['email']?.toString();
    if (fallbackEmail == null || fallbackEmail.isEmpty) {
      return null;
    }

    return CustomerModel(
      firstName: firstName ?? payload['firstName']?.toString() ?? 'Customer',
      lastName: lastName ?? payload['lastName']?.toString() ?? '',
      email: fallbackEmail,
      phoneNumber: phoneNumber ?? payload['phoneNumber']?.toString() ?? '',
      city: city ?? payload['city']?.toString() ?? '',
    );
  }
}

class AuthResult {
  const AuthResult._({required this.success, this.token, this.customer, this.message});

  final bool success;
  final String? token;
  final CustomerModel? customer;
  final String? message;

  factory AuthResult.success({String? token, CustomerModel? customer, String? message}) {
    return AuthResult._(success: true, token: token, customer: customer, message: message);
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(success: false, message: message);
  }
}

class AuthSession {
  const AuthSession({required this.token, required this.customer});

  final String token;
  final CustomerModel customer;
}
