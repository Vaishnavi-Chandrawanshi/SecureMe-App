import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'voice_lessons/voice_lessons_screen.dart';
import 'scam_scanner/elder_scam_scanner.dart';
import 'sos/elder_sos_screen.dart';
import 'safe_internet/elder_safe_internet.dart';

import 'language_controller.dart';
import 'language_strings.dart';

class ElderDashboard extends StatelessWidget {
  const ElderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLanguage.current,
      builder: (context, lang, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F8F7),
          appBar: AppBar(
            title: Text("🧓 ${ElderTexts.t("title")}"),
            backgroundColor: const Color(0xFF0F9D8A),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _elderButton(
                  context,
                  ElderTexts.t("voice"),
                  Icons.volume_up,
                  const Color(0xFF4CAF50),
                  const VoiceLessonsScreen(),
                ),
                _elderButton(
                  context,
                  ElderTexts.t("scam"),
                  Icons.sms_failed,
                  const Color(0xFFFF9800),
                  const ElderScamScanner(),
                ),
                _elderButton(
                  context,
                  ElderTexts.t("sos"),
                  Icons.emergency,
                  const Color(0xFFF44336),
                  const ElderSosScreen(),
                ),
                _elderButton(
                  context,
                  ElderTexts.t("internet"),
                  Icons.shield,
                  const Color(0xFF2196F3),
                  const ElderSafeInternetScreen(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _elderButton(
      BuildContext context,
      String text,
      IconData icon,
      Color color,
      Widget page,
      ) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 34, color: Colors.white),
        label: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
