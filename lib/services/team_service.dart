import 'package:cricket_simuletion/core/constants/api_constants.dart';
import 'package:cricket_simuletion/models/api_response.dart';
import 'package:cricket_simuletion/models/team_model.dart';
import 'package:cricket_simuletion/services/api_service.dart';

class TeamService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TeamModel>>> getAllTeams() async {
    try {
      final response = await _apiService.getRequest(ApiConstants.teams);
      
      // The backend returns a direct List based on your screenshot
      if (response is List) {
        final teams = response.map((json) => TeamModel.fromJson(json)).toList();
        return ApiResponse<List<TeamModel>>(success: true, data: teams);
      } 
      
      // If it's wrapped in the common response format
      return ApiResponse<List<TeamModel>>.fromJson(
        response,
        (data) => (data as List).map((json) => TeamModel.fromJson(json)).toList(),
      );
    } catch (e) {
      return ApiResponse<List<TeamModel>>(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<TeamModel>> createTeam(int hostUserId, String teamName) async {
    try {
      final response = await _apiService.postRequest(ApiConstants.teams, {
        'hostUserId': hostUserId,
        'teamName': teamName,
      });
      
      return ApiResponse<TeamModel>.fromJson(
        response,
        (data) => TeamModel.fromJson(data),
      );
    } catch (e) {
      return ApiResponse<TeamModel>(success: false, message: e.toString());
    }
  }
}