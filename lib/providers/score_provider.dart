// File: lib/providers/score_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cricket_simuletion/models/score_model.dart';
import 'package:cricket_simuletion/services/api_service.dart';

final scoreProvider = StateNotifierProvider.family<ScoreNotifier, AsyncValue<ScoreModel>, int>((ref, matchId) {
  final api = ref.watch(apiServiceProvider);
  return ScoreNotifier(api, matchId);
});

class ScoreNotifier extends StateNotifier<AsyncValue<ScoreModel>> {
  final ApiService _api;
  final int _matchId;

  ScoreNotifier(this._api, this._matchId) : super(const AsyncValue.loading()) {
    getScore();
  }

  Future<void> getScore() async {
    try {
      final data = await _api.get('/matches/$_matchId/scoreboard');
      state = AsyncValue.data(ScoreModel.fromJson(data));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBall({required int runs, String extraType = "NONE", bool isWicket = false}) async {
    try {
      final response = await _api.post('/matches/$_matchId/ball', {
        "runs": runs,
        "extraType": extraType,
        "isWicket": isWicket,
      });
      state = AsyncValue.data(ScoreModel.fromJson(response));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
