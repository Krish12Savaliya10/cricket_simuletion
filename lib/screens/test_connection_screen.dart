// File: lib/screens/test_connection_screen.dart

import 'package:flutter/material.dart';
import 'package:cricket_simuletion/services/api_service.dart';
import 'package:cricket_simuletion/core/constants/api_constants.dart';

class TestConnectionScreen extends StatefulWidget {
  const TestConnectionScreen({super.key});

  @override
  State<TestConnectionScreen> createState() => _TestConnectionScreenState();
}

class _TestConnectionScreenState extends State<TestConnectionScreen> {
  String result = "No response yet";

  Future<void> testApi() async {
    setState(() {
      result = "Connecting to ${ApiConstants.baseUrl}${ApiConstants.teams}...";
    });
    
    try {
      final api = ApiService();
      // Using the upgraded 'get' method instead of the old 'getRequest'
      final response = await api.get(ApiConstants.teams);

      setState(() {
        result = "SUCCESS!\n\nResponse:\n$response";
      });
    } catch (e) {
      setState(() {
        result = "ERROR: $e\n\nTips:\n1. Ensure Spring Boot is running in IntelliJ.\n2. Fix JDBC connection (Port 8889) in application.properties.\n3. Enable CORS (@CrossOrigin) in Spring Boot.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Connection")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("API URL: ${ApiConstants.baseUrl}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: testApi,
              child: const Text("Test Backend Connection"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: const TextStyle(fontFamily: 'Courier'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
