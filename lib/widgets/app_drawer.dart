import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Cricket Admin'),
            accountEmail: const Text('admin@cricketapp.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.sports_cricket,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  route: '/home',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.groups_outlined,
                  title: 'Teams',
                  route: '/teams',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Players',
                  route: '/players',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.sports_cricket_outlined,
                  title: 'Matches',
                  route: '/matches',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.emoji_events_outlined,
                  title: 'Tournaments',
                  route: '/tournaments',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.view_carousel_outlined,
                  title: 'Series',
                  route: '/series',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Audience Dashboard',
                  route: '/audience',
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.api,
                  title: 'Test API Connection',
                  route: '/test-connection',
                ),
              ],
            ),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            route: '/login',
            isReplacement: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    bool isReplacement = false,
  }) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isSelected = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (isSelected) return;
        
        if (isReplacement) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}