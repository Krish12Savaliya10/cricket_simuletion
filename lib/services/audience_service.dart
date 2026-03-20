// File: lib/services/audience_service.dart

import 'package:cricket_simuletion/core/constants/api_constants.dart';
import 'package:cricket_simuletion/models/api_response.dart';
import 'package:cricket_simuletion/models/match_model.dart';
import 'package:cricket_simuletion/services/api_service.dart';

class AudienceService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<MatchModel>>> getMatches({
    required String status,
    required String type,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.matches,
        params: {'status': status, 'type': type},
      );

      // Handle the different response formats (List vs Map with data field)
      if (response is List) {
        final matches = response.map((m) => MatchModel.fromJson(m)).toList();
        return ApiResponse<List<MatchModel>>(success: true, data: matches);
      }

      return ApiResponse<List<MatchModel>>.fromJson(
        response,
        (data) => (data as List).map((m) => MatchModel.fromJson(m)).toList(),
      );
    } catch (e) {
      return ApiResponse<List<MatchModel>>(success: false, message: e.toString());
    }
  }

  Future<dynamic> getAudienceDashboard() async {
    try {
      return await _apiService.get(ApiConstants.audienceDashboard);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
