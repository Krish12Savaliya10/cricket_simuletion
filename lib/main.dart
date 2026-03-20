import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cricket_simuletion/core/theme/app_theme.dart';
import 'package:cricket_simuletion/screens/auth/login_screen.dart';
import 'package:cricket_simuletion/screens/auth/signup_screen.dart';
import 'package:cricket_simuletion/screens/home/home_screen.dart';
import 'package:cricket_simuletion/screens/teams/teams_screen.dart';
import 'package:cricket_simuletion/screens/players/players_screen.dart';
import 'package:cricket_simuletion/screens/match/matches_screen.dart';
import 'package:cricket_simuletion/screens/match/scoreboard_screen.dart';
import 'package:cricket_simuletion/screens/tournaments/tournaments_screen.dart';
import 'package:cricket_simuletion/screens/series/series_screen.dart';
import 'package:cricket_simuletion/screens/audience/audience_dashboard_screen.dart';
import 'package:cricket_simuletion/screens/test_connection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Open a box for offline storage if needed
  await Hive.openBox('offline_events');
  
  runApp(
    const ProviderScope(
      child: CricketApp(),
    ),
  );
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        if (settings.name == '/scoreboard') {
          final matchId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => ScoreboardScreen(matchId: matchId),
          );
        }
        return null;
      },
      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/home': (_) => const HomeScreen(),
        '/teams': (_) => const TeamsScreen(),
        '/players': (_) => const PlayersScreen(),
        '/matches': (_) => const MatchesScreen(),
        '/tournaments': (_) => const TournamentsScreen(),
        '/series': (_) => const SeriesScreen(),
        '/audience': (_) => const AudienceDashboardScreen(),
        '/test-connection': (_) => const TestConnectionScreen(),
      },
    );
  }
}