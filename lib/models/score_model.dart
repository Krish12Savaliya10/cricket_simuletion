// File: lib/models/score_model.dart

class ScoreModel {
  final int totalRuns;
  final int wickets;
  final String overs;
  final String? lastEvent;
  final double? crr;
  final int? target;

  ScoreModel({
    required this.totalRuns,
    required this.wickets,
    required this.overs,
    this.lastEvent,
    this.crr,
    this.target,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      totalRuns: json['totalRuns'] ?? 0,
      wickets: json['wickets'] ?? 0,
      overs: json['overs']?.toString() ?? "0.0",
      lastEvent: json['lastEvent'],
      crr: (json['crr'] as num?)?.toDouble(),
      target: json['target'],
    );
  }

  ScoreModel copyWith({
    int? totalRuns,
    int? wickets,
    String? overs,
    String? lastEvent,
    double? crr,
    int? target,
  }) {
    return ScoreModel(
      totalRuns: totalRuns ?? this.totalRuns,
      wickets: wickets ?? this.wickets,
      overs: overs ?? this.overs,
      lastEvent: lastEvent ?? this.lastEvent,
      crr: crr ?? this.crr,
      target: target ?? this.target,
    );
  }
}
