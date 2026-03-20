import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cricket_simuletion/models/scoreboard_model.dart';
import 'package:cricket_simuletion/services/scoring_service.dart';

final scoringServiceProvider = Provider((ref) => ScoringService());

class ScoringState {
  final ScoreboardModel? scoreboard;
  final bool isLoading;
  final String? error;

  ScoringState({this.scoreboard, this.isLoading = false, this.error});

  ScoringState copyWith({ScoreboardModel? scoreboard, bool? isLoading, String? error}) {
    return ScoringState(
      scoreboard: scoreboard ?? this.scoreboard,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ScoringNotifier extends StateNotifier<ScoringState> {
  final ScoringService _service;
  final int matchId;

  ScoringNotifier(this._service, this.matchId) : super(ScoringState()) {
    fetchScoreboard();
  }

  Future<void> fetchScoreboard() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final scoreboard = await _service.getScoreboard(matchId);
      state = state.copyWith(scoreboard: scoreboard, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addBall(Map<String, dynamic> ballData) async {
    state = state.copyWith(isLoading: true);
    try {
      final scoreboard = await _service.addBall(matchId, ballData);
      state = state.copyWith(scoreboard: scoreboard, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> undo() async {
    state = state.copyWith(isLoading: true);
    try {
      final scoreboard = await _service.undoBall(matchId);
      state = state.copyWith(scoreboard: scoreboard, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final scoringProvider = StateNotifierProvider.family<ScoringNotifier, ScoringState, int>((ref, matchId) {
  final service = ref.watch(scoringServiceProvider);
  return ScoringNotifier(service, matchId);
});
