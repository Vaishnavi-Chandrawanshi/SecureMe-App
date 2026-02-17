import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tips_data.dart';

class DailyTipsScreen extends StatelessWidget {
  const DailyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tip = dailyTips["en"]!.first;
    final FlutterTts tts = FlutterTts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("💡 Daily Safety Tip"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tip,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 26),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.volume_up),
                label: const Text("Listen"),
                onPressed: () async {
                  await tts.setSpeechRate(0.4);
                  await tts.speak(tip);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
