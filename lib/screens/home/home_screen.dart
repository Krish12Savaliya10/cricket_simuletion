import 'package:flutter/material.dart';
import 'package:cricket_simuletion/widgets/app_drawer.dart';
import 'package:cricket_simuletion/widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Teams',
        'subtitle': 'Manage team list',
        'icon': Icons.groups,
        'route': '/teams',
      },
      {
        'title': 'Players',
        'subtitle': 'Manage player profiles',
        'icon': Icons.person,
        'route': '/players',
      },
      {
        'title': 'Matches',
        'subtitle': 'Create and track matches',
        'icon': Icons.sports_cricket,
        'route': '/matches',
      },
      {
        'title': 'Tournaments',
        'subtitle': 'Create tournaments',
        'icon': Icons.emoji_events,
        'route': '/tournaments',
      },
      {
        'title': 'Series',
        'subtitle': 'Track series records',
        'icon': Icons.view_carousel,
        'route': '/series',
      },
      {
        'title': 'Audience',
        'subtitle': 'Live dashboard and stats',
        'icon': Icons.dashboard,
        'route': '/audience',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Cricket Dashboard')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Cricket App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage teams, matches, tournaments, and live scoreboards.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: .95,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return DashboardCard(
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String,
                    icon: item['icon'] as IconData,
                    onTap: () => Navigator.pushNamed(
                      context,
                      item['route'] as String,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}