class MatchModel {
  final int matchId;
  final String team1Name;
  final String team2Name;

  MatchModel({
    required this.matchId,
    required this.team1Name,
    required this.team2Name,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      matchId: json['matchId'] ?? 0,
      team1Name: json['team1Name'] ?? '',
      team2Name: json['team2Name'] ?? '',
    );
  }
}