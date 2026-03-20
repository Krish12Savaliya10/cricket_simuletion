import 'package:cricket_simuletion/models/player_score_model.dart';

class ScoreboardModel {
  final int matchId;
  final int inningsNo;
  final int battingTeamId;
  final int bowlingTeamId;
  final int totalRuns;
  final int wickets;
  final String oversDisplay;
  final PlayerScoreModel? striker;
  final PlayerScoreModel? nonStriker;
  final BowlerScoreModel? currentBowler;
  final int? target;
  final String status;
  final String? lastEvent;

  ScoreboardModel({
    required this.matchId,
    required this.inningsNo,
    required this.battingTeamId,
    required this.bowlingTeamId,
    required this.totalRuns,
    required this.wickets,
    required this.oversDisplay,
    this.striker,
    this.nonStriker,
    this.currentBowler,
    this.target,
    required this.status,
    this.lastEvent,
  });

  factory ScoreboardModel.fromJson(Map<String, dynamic> json) {
    return ScoreboardModel(
      matchId: json['matchId'] ?? 0,
      inningsNo: json['inningsNo'] ?? 1,
      battingTeamId: json['battingTeamId'] ?? 0,
      bowlingTeamId: json['bowlingTeamId'] ?? 0,
      totalRuns: json['totalRuns'] ?? 0,
      wickets: json['wickets'] ?? 0,
      oversDisplay: json['oversDisplay'] ?? '0.0',
      striker: json['striker'] != null ? PlayerScoreModel.fromJson(json['striker']) : null,
      nonStriker: json['nonStriker'] != null ? PlayerScoreModel.fromJson(json['nonStriker']) : null,
      currentBowler: json['currentBowler'] != null ? BowlerScoreModel.fromJson(json['currentBowler']) : null,
      target: json['target'],
      status: json['status'] ?? 'UPCOMING',
      lastEvent: json['lastEvent'],
    );
  }
}