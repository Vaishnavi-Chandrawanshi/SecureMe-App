import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'safety_stories.dart';
import 'quiz/quiz_screen.dart';
import 'games/scam_game.dart';
import 'safe_internet.dart';
import 'progress.dart';

class KidsDashboard extends StatelessWidget {
  const KidsDashboard({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎮 Kids Safety Zone"),
        centerTitle: true,
        backgroundColor: const Color(0xFF6A5AE0), // purple-blue modern
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB7EDE7), // light aqua
              Color(0xFFE8F7FF), // soft sky
              Color(0xFFFFE4F2), // light pink (kids friendly)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  /// GRID SECTION
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    children: [
                      _kidsCard(
                        context,
                        title: "📖 Stories",
                        subtitle: "Learn with fun stories",
                        icon: Icons.menu_book_rounded,
                        color: Colors.orange,
                        page: const SafetyStoriesScreen(),
                      ),
                      _kidsCard(
                        context,
                        title: "🧠 Quiz",
                        subtitle: "Play & learn safety",
                        icon: Icons.quiz_rounded,
                        color: Colors.purple,
                        page: const QuizScreen(),
                      ),
                      _kidsCard(
                        context,
                        title: "🚨 Scam Game",
                        subtitle: "Spot the danger",
                        icon: Icons.warning_amber_rounded,
                        color: Colors.redAccent,
                        page: const ScamGameScreen(),
                      ),
                      _kidsCard(
                        context,
                        title: "🌐 Safe Net",
                        subtitle: "Internet rules",
                        icon: Icons.public,
                        color: Colors.blue,
                        page: const SafeInternetScreen(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// PROGRESS CARD
                  SizedBox(
                    height: 160,
                    child: _kidsCard(
                      context,
                      title: "🏆 My Progress",
                      subtitle: "Achievements & rewards",
                      icon: Icons.emoji_events,
                      color: Colors.green,
                      page: const ProgressScreen(),
                      fullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
    }

  // ===================== CARD WIDGET =====================
  Widget _kidsCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required Widget page,
        bool fullWidth = false,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        width: fullWidth ? double.infinity : null,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withValues(alpha: 0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: fullWidth ? 56 : 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: fullWidth ? 20 : 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .scale(duration: 350.ms)
        .fadeIn(duration: 500.ms);
  }
}
