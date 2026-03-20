// File: lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.sports_cricket, size: 28),
            SizedBox(width: 10),
            Text('CRICKET APP', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Live Matches'),
            const SizedBox(height: 12),
            _buildMatchCard(context, 'India', 'Australia', '156/3 (17.2)', 'Live', isLive: true),
            const SizedBox(height: 24),
            _buildSectionHeader('Upcoming Matches'),
            const SizedBox(height: 12),
            _buildMatchCard(context, 'England', 'Pakistan', 'Starts at 7:00 PM', 'Upcoming'),
            const SizedBox(height: 24),
            _buildSectionHeader('Top Players'),
            const SizedBox(height: 12),
            _buildPlayerList(),
            const SizedBox(height: 24),
            _buildSectionHeader('Nearby Tournaments'),
            const SizedBox(height: 12),
            _buildTournamentCard('City Champions Trophy 2024', 'Starts in 2 days'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'My Matches'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Quick Match'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'My Team'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMatchCard(BuildContext context, String t1, String t2, String score, String status, {bool isLive = false}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTeamInfo(t1),
                const Text('VS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                _buildTeamInfo(t2),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(score, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isLive ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isLive ? Colors.red : Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(String name) {
    return Column(
      children: [
        CircleAvatar(radius: 20, backgroundColor: Colors.grey[200], child: const Icon(Icons.flag_outlined)),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildPlayerList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                const SizedBox(height: 6),
                Text('Player ${index + 1}', style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTournamentCard(String name, String date) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.emoji_events, color: Colors.amber),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
