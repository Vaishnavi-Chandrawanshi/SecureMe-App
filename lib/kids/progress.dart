import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'progress_firebase_service.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int storiesRead = 0;
  int quizzesCompleted = 0;
  int scamsAvoided = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final service = ProgressFirebaseService();
    final data = await service.fetchProgress();

    setState(() {
      storiesRead = data['storiesRead']!;
      quizzesCompleted = data['quizzesCompleted']!;
      scamsAvoided = data['scamsAvoided']!;
      loading = false;
    });
  }

  // -------- LEVEL LOGIC (UNCHANGED) --------
  String get level {
    final total = storiesRead + quizzesCompleted + scamsAvoided;
    if (total >= 10) return "Cyber Hero 🦸‍♂️";
    if (total >= 6) return "Safety Champ 🏆";
    if (total >= 3) return "Smart Surfer 🌊";
    return "New Explorer 🚀";
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FB),
      appBar: AppBar(
        title: const Text("🏆 My Progress"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🎉 HEADER
            Center(
              child: Column(
                children: [
                  Text(
                    "Great Job! 🎉",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Level: $level",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 📊 PROGRESS CARDS
            _progressCard(
              icon: Icons.menu_book,
              title: "Stories Read",
              value: storiesRead,
              max: 5,
              color: Colors.orange,
            ),
            _progressCard(
              icon: Icons.quiz,
              title: "Quizzes Completed",
              value: quizzesCompleted,
              max: 5,
              color: Colors.purple,
            ),
            _progressCard(
              icon: Icons.shield,
              title: "Scams Avoided",
              value: scamsAvoided,
              max: 5,
              color: Colors.redAccent,
            ),

            const SizedBox(height: 30),

            // 🏅 BADGES
            Text(
              "🏅 Achievements",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _badge("📖", "Reader", storiesRead >= 3),
                _badge("🧠", "Quiz Star", quizzesCompleted >= 3),
                _badge("🚨", "Scam Buster", scamsAvoided >= 3),
                _badge("🦸", "Hero",
                    storiesRead + quizzesCompleted + scamsAvoided >= 10),
              ],
            ),

            const SizedBox(height: 30),

            // 🔥 DAILY CHALLENGE
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Today's Challenge:\nRead 1 story 📖",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 👨‍👩‍👧 PARENT NOTE
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "👨‍👩‍👧 Parent Note:\nYour child is learning safe digital habits and improving online awareness.",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- WIDGETS (UNCHANGED) ----------------

  Widget _progressCard({
    required IconData icon,
    required String title,
    required int value,
    required int max,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text("$value / $max"),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: value / max,
            backgroundColor: Colors.grey[300],
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _badge(String emoji, String label, bool unlocked) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor:
          unlocked ? Colors.amber : Colors.grey[300],
          child: Text(
            unlocked ? emoji : "🔒",
            style: const TextStyle(fontSize: 22),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: unlocked ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
