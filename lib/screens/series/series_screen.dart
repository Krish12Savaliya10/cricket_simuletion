import 'package:flutter/material.dart';
import 'package:cricket_simuletion/services/mock_data_service.dart';
import 'package:cricket_simuletion/widgets/app_drawer.dart';

class SeriesScreen extends StatelessWidget {
  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seriesList = MockDataService.series;

    return Scaffold(
      appBar: AppBar(title: const Text('Series')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_chart),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: seriesList.length,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.view_carousel)),
              title: Text(series['name']),
              subtitle: Text(
                '${series['matches']} Matches • ${series['type']}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}