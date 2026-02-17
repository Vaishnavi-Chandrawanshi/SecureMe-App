import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ElderSosScreen extends StatelessWidget {
  const ElderSosScreen({super.key});

  Future<void> _callNumber(String number) async {
    final Uri uri = Uri(scheme: 'tel', path: number);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint("Could not launch dialer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🚨 Emergency SOS"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 90),
              ),
              onPressed: () => _callNumber("112"),
              child: const Text(
                "🚓 Call Police (112)",
                style: TextStyle(fontSize: 22),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 80),
              ),
              onPressed: () => _callNumber("108"),
              child: const Text(
                "🚑 Call Ambulance (108)",
                style: TextStyle(fontSize: 22),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 80),
              ),
              onPressed: () => _callNumber("9226497610"), // demo family number
              child: const Text(
                "👨‍👩‍👧 Call Family Member",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

