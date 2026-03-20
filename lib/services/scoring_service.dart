import 'package:dio/dio.dart';
import 'package:cricket_simuletion/core/constants/api_constants.dart';
import 'package:cricket_simuletion/models/scoreboard_model.dart';

class ScoringService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<ScoreboardModel> getScoreboard(int matchId) async {
    try {
      final response = await _dio.get('/matches/$matchId/scoreboard');
      return ScoreboardModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ScoreboardModel> addBall(int matchId, Map<String, dynamic> ballData) async {
    try {
      final response = await _dio.post('/matches/$matchId/ball', data: ballData);
      return ScoreboardModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ScoreboardModel> undoBall(int matchId) async {
    try {
      final response = await _dio.post('/matches/$matchId/undo-last-ball');
      return ScoreboardModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}