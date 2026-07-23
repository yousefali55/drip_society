import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConstants {
  const ApiConstants._();

  static String get baseUrl {
    const envUrl = String.fromEnvironment('API_BASE_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }

    if (kIsWeb) {
      return 'https://drip-society-backend.onrender.com/api';
    }

    if (Platform.isAndroid) {
      return 'https://drip-society-backend.onrender.com/api';
    }

    return 'https://drip-society-backend.onrender.com/api';
  }

  static const String productsEndpoint = '/products';
}
