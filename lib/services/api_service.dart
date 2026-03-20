import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cricket_simuletion/core/constants/api_constants.dart';

class ApiService {
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> getRequest(String endpoint, {Map<String, String>? queryParams}) async {
    var uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    if (kDebugMode) {
      print('DEBUG: GET Request to $uri');
    }

    try {
      final response = await http.get(uri, headers: await _headers());
      return _processResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print('DEBUG: GET Request failed: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    
    if (kDebugMode) {
      print('DEBUG: POST Request to $uri');
      print('DEBUG: Body: ${jsonEncode(body)}');
    }

    try {
      final response = await http.post(
        uri,
        headers: await _headers(),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print('DEBUG: POST Request failed: $e');
      }
      rethrow;
    }
  }

  dynamic _processResponse(http.Response response) {
    if (kDebugMode) {
      print('DEBUG: Response Status: ${response.statusCode}');
      print('DEBUG: Response Body: ${response.body}');
    }

    if (response.body.isEmpty) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'success': true, 'data': null};
      }
      throw Exception('Empty response with status ${response.statusCode}');
    }

    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      throw Exception('Failed to parse JSON: ${response.body.substring(0, response.body.length > 100 ? 100 : response.body.length)}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      // Handle standard error format or direct message
      final message = body is Map ? (body['message'] ?? body['error'] ?? 'Unknown Error') : body.toString();
      throw Exception(message);
    }
  }
}