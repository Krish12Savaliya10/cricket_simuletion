class SeriesModel {
  final String seriesId;
  final String seriesName;
  final int year;
  final int totalMatches;
  final int completedMatches;
  final String seriesStatus;

  SeriesModel({
    required this.seriesId,
    required this.seriesName,
    required this.year,
    required this.totalMatches,
    required this.completedMatches,
    required this.seriesStatus,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      seriesId: json['seriesId']?.toString() ?? '',
      seriesName: json['seriesName'] ?? '',
      year: json['year'] ?? 0,
      totalMatches: json['totalMatches'] ?? 0,
      completedMatches: json['completedMatches'] ?? 0,
      seriesStatus: json['seriesStatus'] ?? '',
    );
  }
}