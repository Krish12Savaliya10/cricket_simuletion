// File: lib/services/auth_service.dart

import 'package:cricket_simuletion/core/constants/api_constants.dart';
import 'package:cricket_simuletion/models/api_response.dart';
import 'package:cricket_simuletion/models/user.dart';
import 'package:cricket_simuletion/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<User>> signup({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _apiService.post(ApiConstants.signup, {
        'fullName': fullName,
        'email': email,
        'password': password,
        'role': role,
      });

      // Flexible parsing: check if wrapped in 'data' or is the object itself
      if (response is Map<String, dynamic> && response.containsKey('userId')) {
        return ApiResponse<User>(success: true, data: User.fromJson(response));
      }

      return ApiResponse<User>.fromJson(
        response,
        (data) => User.fromJson(data),
      );
    } catch (e) {
      return ApiResponse<User>(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(ApiConstants.login, {
        'email': email,
        'password': password,
      });

      // Flexible parsing for Login response
      User? user;
      if (response is Map<String, dynamic>) {
        if (response.containsKey('userId')) {
          user = User.fromJson(response);
        } else if (response.containsKey('data') && response['data'] != null) {
          user = User.fromJson(response['data']);
        }
      }

      if (user != null) {
        final apiResponse = ApiResponse<User>(success: true, data: user);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', user.userId);
        await prefs.setString('user_role', user.role);
        await prefs.setString('user_email', user.email);
        
        return apiResponse;
      }

      return ApiResponse<User>(
        success: false, 
        message: response is Map ? (response['message'] ?? 'Invalid response format') : 'Server error'
      );
    } catch (e) {
      return ApiResponse<User>(success: false, message: e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
