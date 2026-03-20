// File: lib/screens/match/scoreboard_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cricket_simuletion/widgets/run_button.dart';
import 'package:cricket_simuletion/widgets/scoreboard_panel.dart';
import 'package:cricket_simuletion/widgets/ball_history_row.dart';
import 'package:cricket_simuletion/providers/score_provider.dart';

class ScoreboardScreen extends ConsumerWidget {
  final int matchId;

  const ScoreboardScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreState = ref.watch(scoreProvider(matchId));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('India vs Australia', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        elevation: 0,
      ),
      body: scoreState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (score) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ScoreboardPanel(
                      runs: score.totalRuns,
                      wickets: score.wickets,
                      overs: score.overs,
                      crr: 7.82, // Example CRR
                    ),
                    const SizedBox(height: 16),
                    _buildBatsmanSection(context),
                    const SizedBox(height: 16),
                    _buildBowlerSection(context),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('LAST 12 BALLS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                    const SizedBox(height: 8),
                    const BallHistoryRow(lastBalls: ['1', '4', '0', 'W', '2', '6', '1', '1', '0', '4', '0', '1']),
                  ],
                ),
              ),
            ),
            _buildInputPanel(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildBatsmanSection(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildBatsmanRow('Virat Kohli', '42', '28', true),
          const Divider(height: 1),
          _buildBatsmanRow('Rohit Sharma', '15', '12', false),
        ],
      ),
    );
  }

  Widget _buildBatsmanRow(String name, String runs, String balls, bool isStriker) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isStriker ? Colors.blue.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.sports_cricket, size: 16, color: isStriker ? Colors.blue : Colors.grey),
          const SizedBox(width: 10),
          Text(
            name,
            style: TextStyle(
              fontWeight: isStriker ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            '$runs ($balls)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBowlerSection(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: const CircleAvatar(radius: 18, child: Icon(Icons.person, size: 20)),
        title: const Text('Mitchell Starc', style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: const Text('3.2 - 0 - 24 - 1', style: TextStyle(fontSize: 12)),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('ECON', style: TextStyle(fontSize: 10, color: Colors.grey)),
            Text('7.20', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputPanel(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(scoreProvider(matchId).notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              RunButton(label: '0', onTap: () => notifier.addBall(runs: 0)),
              RunButton(label: '1', onTap: () => notifier.addBall(runs: 1)),
              RunButton(label: '2', onTap: () => notifier.addBall(runs: 2)),
              RunButton(label: '3', onTap: () => notifier.addBall(runs: 3)),
              RunButton(label: '4', onTap: () => notifier.addBall(runs: 4), color: Colors.green[50], textColor: Colors.green[800]),
              RunButton(label: '6', onTap: () => notifier.addBall(runs: 6), color: Colors.blue[50], textColor: Colors.blue[800]),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              RunButton(label: 'WD', onTap: () => notifier.addBall(runs: 0, extraType: "WIDE"), color: Colors.orange[50], textColor: Colors.orange[800]),
              RunButton(label: 'NB', onTap: () => notifier.addBall(runs: 0, extraType: "NO_BALL"), color: Colors.red[50], textColor: Colors.red[800]),
              RunButton(label: 'BYE', onTap: () => notifier.addBall(runs: 0, extraType: "BYE")),
              RunButton(label: 'LB', onTap: () => notifier.addBall(runs: 0, extraType: "LB")),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              RunButton(
                label: 'WICKET',
                onTap: () => notifier.addBall(runs: 0, isWicket: true),
                color: Colors.red[600],
                textColor: Colors.white,
              ),
              RunButton(label: 'UNDO', onTap: () {}, color: Colors.grey[200]),
              RunButton(label: 'END MATCH', onTap: () {}, color: Colors.grey[800], textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
