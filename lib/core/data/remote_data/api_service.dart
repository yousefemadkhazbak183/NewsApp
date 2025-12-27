import 'dart:convert';

import 'package:flutter_news_app/core/data/remote_data/api_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._();

  factory ApiService() => _instance;
  ApiService._();
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? query}) async {
    final url = Uri.http(ApiConfig.baseUrl, 'v2/$endPoint', {"apiKey": ApiConfig.apiKey, ...?query});
    try {
      final http.Response response = await http.get(url);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Failed error message");
    }
  }
}
