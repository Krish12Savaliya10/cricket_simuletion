import 'package:flutter/material.dart';
import 'package:cricket_simuletion/services/mock_data_service.dart';
import 'package:cricket_simuletion/widgets/app_drawer.dart';

class TournamentsScreen extends StatelessWidget {
  const TournamentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tournaments = MockDataService.tournaments;

    return Scaffold(
      appBar: AppBar(title: const Text('Tournaments')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.emoji_events),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.emoji_events)),
              title: Text(tournament['name']),
              subtitle: Text(
                'Teams: ${tournament['teams']} • Format: ${tournament['format']}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}