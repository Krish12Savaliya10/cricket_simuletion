import 'package:flutter/foundation.dart';

class ApiConstants {
  static String get baseUrl {
    // Port for your Spring Boot API server (usually 8080)
    const String port = '8080'; 

    if (kIsWeb) {
      return 'http://localhost:$port/api/v1';
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:$port/api/v1';
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'http://localhost:$port/api/v1';
      default:
        return 'http://localhost:$port/api/v1';
    }
  }

  // Auth
  static const String signup = '/auth/signup';
  static const String login = '/auth/login';

  // Teams
  static const String teams = '/teams';
  static String teamPlayers(int teamId) => '/teams/$teamId/players';

  // Matches
  static const String singleMatch = '/matches/single';
  static const String matches = '/matches';
  static String matchDetails(int matchId) => '/matches/$matchId';
  static String startInnings(int matchId, int inningsNo) => '/matches/$matchId/innings/$inningsNo/start';
  static String submitBall(int matchId) => '/matches/$matchId/ball';
  static String scoreboard(int matchId) => '/matches/$matchId/scoreboard';
  static String undoBall(int matchId) => '/matches/$matchId/undo-last-ball';

  // Series
  static const String series = '/series';
  static String seriesDetails(int seriesId) => '/series/$seriesId';

  // Tournaments
  static const String tournaments = '/tournaments';
  static String tournamentDetails(int tournamentId) => '/tournaments/$tournamentId';
  static String pointsTable(int tournamentId) => '/tournaments/$tournamentId/points-table';

  // Audience
  static const String audienceDashboard = '/audience/dashboard';
}