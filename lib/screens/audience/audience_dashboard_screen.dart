import 'package:flutter/material.dart';
import 'package:cricket_simuletion/models/match_model.dart';
import 'package:cricket_simuletion/services/audience_service.dart';
import 'package:cricket_simuletion/widgets/app_drawer.dart';

class AudienceDashboardScreen extends StatefulWidget {
  const AudienceDashboardScreen({super.key});

  @override
  State<AudienceDashboardScreen> createState() => _AudienceDashboardScreenState();
}

class _AudienceDashboardScreenState extends State<AudienceDashboardScreen> {
  final AudienceService _audienceService = AudienceService();
  bool _isLoading = true;
  List<MatchModel> _liveMatches = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final response = await _audienceService.getMatches(status: 'LIVE', type: 'SINGLE');

    if (mounted) {
      if (response.success) {
        setState(() {
          _liveMatches = response.data ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = response.message;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audience Dashboard'),
        actions: [
          IconButton(onPressed: _fetchData, icon: const Icon(Icons.refresh)),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _error != null
          ? Center(child: Text('Error: $_error'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Matches',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (_liveMatches.isEmpty)
                    const Center(child: Text('No live matches at the moment.'))
                  else
                    ..._liveMatches.map((match) => _buildMatchCard(match)),
                ],
              ),
            ),
    );
  }

  Widget _buildMatchCard(MatchModel match) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.live_tv, color: Colors.red)),
        title: Text('${match.team1Name} vs ${match.team2Name}'),
        subtitle: const Text('Status: LIVE'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to match details
        },
      ),
    );
  }
}