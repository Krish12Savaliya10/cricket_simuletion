// File: lib/services/team_service.dart

import 'package:cricket_simuletion/core/constants/api_constants.dart';
import 'package:cricket_simuletion/models/api_response.dart';
import 'package:cricket_simuletion/models/team_model.dart';
import 'package:cricket_simuletion/services/api_service.dart';

class TeamService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TeamModel>>> getAllTeams() async {
    try {
      final response = await _apiService.get(ApiConstants.teams);
      
      // If backend returns a List directly: [{}, {}]
      if (response is List) {
        final List<TeamModel> teams = response
            .map((e) => TeamModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        return ApiResponse<List<TeamModel>>(success: true, data: teams);
      } 
      
      // If backend returns wrapped response: { success: true, data: [{}, {}] }
      if (response is Map) {
        final Map<String, dynamic> responseMap = Map<String, dynamic>.from(response);
        
        if (responseMap.containsKey('data') && responseMap['data'] is List) {
          final List<dynamic> dataList = responseMap['data'] as List;
          final List<TeamModel> teams = dataList
              .map((e) => TeamModel.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList();
          return ApiResponse<List<TeamModel>>(success: true, data: teams);
        }
        
        // Fallback to standard factory
        return ApiResponse<List<TeamModel>>.fromJson(
          responseMap,
          (data) => (data as List)
              .map((e) => TeamModel.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
        );
      }

      return ApiResponse<List<TeamModel>>(success: false, message: 'Invalid response format');
    } catch (e) {
      return ApiResponse<List<TeamModel>>(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<TeamModel>> createTeam(int hostUserId, String teamName) async {
    try {
      final response = await _apiService.post(ApiConstants.teams, {
        'hostUserId': hostUserId,
        'teamName': teamName,
      });
      
      if (response is Map) {
        final Map<String, dynamic> responseMap = Map<String, dynamic>.from(response);
        
        if (responseMap.containsKey('id')) {
           return ApiResponse<TeamModel>(success: true, data: TeamModel.fromJson(responseMap));
        }
        
        return ApiResponse<TeamModel>.fromJson(
          responseMap,
          (data) => TeamModel.fromJson(Map<String, dynamic>.from(data as Map)),
        );
      }

      return ApiResponse<TeamModel>(success: false, message: 'Invalid response format');
    } catch (e) {
      return ApiResponse<TeamModel>(success: false, message: e.toString());
    }
  }
}
