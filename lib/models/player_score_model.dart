class PlayerScoreModel {
  final int playerId;
  final String? playerName;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final String battingStatus;

  PlayerScoreModel({
    required this.playerId,
    this.playerName,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.battingStatus,
  });

  factory PlayerScoreModel.fromJson(Map<String, dynamic> json) {
    return PlayerScoreModel(
      playerId: json['playerId'] ?? 0,
      playerName: json['playerName'],
      runs: json['runs'] ?? 0,
      balls: json['balls'] ?? 0,
      fours: json['fours'] ?? 0,
      sixes: json['sixes'] ?? 0,
      battingStatus: json['battingStatus'] ?? 'NOT_OUT',
    );
  }
}

class BowlerScoreModel {
  final int playerId;
  final String? playerName;
  final String oversDisplay;
  final int wickets;
  final int runsConceded;

  BowlerScoreModel({
    required this.playerId,
    this.playerName,
    required this.oversDisplay,
    required this.wickets,
    required this.runsConceded,
  });

  factory BowlerScoreModel.fromJson(Map<String, dynamic> json) {
    return BowlerScoreModel(
      playerId: json['playerId'] ?? 0,
      playerName: json['playerName'],
      oversDisplay: json['oversDisplay'] ?? '0.0',
      wickets: json['wickets'] ?? 0,
      runsConceded: json['runsConceded'] ?? 0,
    );
  }
}