import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language_controller.dart';
import 'lessons_data.dart';

class VoiceLessonsScreen extends StatefulWidget {
  const VoiceLessonsScreen({super.key});

  @override
  State<VoiceLessonsScreen> createState() => _VoiceLessonsScreenState();
}

class _VoiceLessonsScreenState extends State<VoiceLessonsScreen> {
  final FlutterTts _tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLanguage.current,
      builder: (context, lang, _) {
        final tips = elderLessons[lang]!;

        return Scaffold(
          appBar: AppBar(
            title: const Text("🎧 Voice Safety Tips"),
            backgroundColor: Colors.teal,
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return _tipCard(
                text: tips[index],
                index: index,
                onTap: () => _speak(tips[index], lang),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _speak(String text, String lang) async {
    await _tts.stop();
    await _tts.setLanguage(
      lang == "hi"
          ? "hi-IN"
          : lang == "mr"
          ? "mr-IN"
          : "en-US",
    );
    await _tts.setSpeechRate(0.45);
    await _tts.speak(text);
  }

  Widget _tipCard({
    required String text,
    required int index,
    required VoidCallback onTap,
  }) {
    final isEven = index % 2 == 0;
    final bg = isEven ? const Color(0xFFEAFBF7) : const Color(0xFFEAF1FB);
    final iconColor = isEven ? Colors.teal : Colors.blue;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
          IconButton(
            icon: Icon(Icons.volume_up, color: iconColor),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
