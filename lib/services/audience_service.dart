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
      // The constant name was changed to 'matches' for general and 'audienceDashboard' for dashboard
      // According to your last endpoint list, audience has a unified dashboard
      final response = await _apiService.getRequest(
        ApiConstants.matches, // Updated to use the correct constant
        queryParams: {'status': status, 'type': type},
      );

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
      return await _apiService.getRequest(ApiConstants.audienceDashboard);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}