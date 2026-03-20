class TeamModel {
  final int id;
  final String teamName;
  final int hostUserId;

  TeamModel({
    required this.id,
    required this.teamName,
    required this.hostUserId,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? 0,
      teamName: json['teamName'] ?? '',
      hostUserId: json['hostUserId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamName': teamName,
      'hostUserId': hostUserId,
    };
  }
}