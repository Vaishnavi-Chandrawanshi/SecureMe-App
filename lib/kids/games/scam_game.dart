import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../progress_firebase_service.dart';

class ScamGameScreen extends StatefulWidget {
  const ScamGameScreen({super.key});

  @override
  State<ScamGameScreen> createState() => _ScamGameScreenState();
}

class _ScamGameScreenState extends State<ScamGameScreen> {
  late List<ScamQuestion> questions;
  int currentIndex = 0;
  int score = 0;
  bool progressUpdated = false;

  @override
  void initState() {
    super.initState();
    questions = List<ScamQuestion>.from(allScamQuestions);
    questions.shuffle();
    questions = questions.take(5).toList(); // 5 per game
  }

  void answer(bool userChoice) {
    if (userChoice == questions[currentIndex].isScam) {
      score++;
    }

    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= questions.length) {
      _updateProgressOnce();
      return _resultScreen();
    }

    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("🚨 Scam Alert Game"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFEBEE),
              Color(0xFFFFF3E0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Question ${currentIndex + 1} / ${questions.length}",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "🕵️ Is this message SAFE or SCAM?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      q.message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text("SAFE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => answer(false),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                icon: const Icon(Icons.warning),
                label: const Text("SCAM"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () => answer(true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 FIREBASE UPDATE (ONLY ONCE)
  Future<void> _updateProgressOnce() async {
    if (progressUpdated) return;
    progressUpdated = true;

    final service = ProgressFirebaseService();
    await service.incrementScamsAvoided();
  }

  Widget _resultScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        title: const Text("🏆 Result"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              score >= 3 ? Icons.emoji_events : Icons.shield,
              size: 100,
              color: Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              "You scored $score / ${questions.length}",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Play Again"),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== MODEL ===================== */

class ScamQuestion {
  final String message;
  final bool isScam;

  ScamQuestion({required this.message, required this.isScam});
}

/* ===================== 50 SCAM QUESTIONS ===================== */

final List<ScamQuestion> allScamQuestions = [
  ScamQuestion(message: "🎁 You won a free phone! Click here now.", isScam: true),
  ScamQuestion(message: "👩‍👩‍👧 Your mom sent this message from her phone.", isScam: false),
  ScamQuestion(message: "📦 Your parcel is stuck. Pay ₹50 to release.", isScam: true),
  ScamQuestion(message: "🏫 School holiday notice from teacher.", isScam: false),
  ScamQuestion(message: "🔐 Share OTP to secure your account.", isScam: true),
  ScamQuestion(message: "🎮 Free game coins! Claim now.", isScam: true),
  ScamQuestion(message: "📞 Unknown caller says you won prize.", isScam: true),
  ScamQuestion(message: "👨‍👩‍👦 Dad asking where you are.", isScam: false),
  ScamQuestion(message: "💳 Enter card details to get cashback.", isScam: true),
  ScamQuestion(message: "📚 Homework reminder from teacher.", isScam: false),

  ScamQuestion(message: "🎁 Lucky draw winner announcement!", isScam: true),
  ScamQuestion(message: "📧 Email asking password reset urgently.", isScam: true),
  ScamQuestion(message: "🧑‍🏫 Teacher shared class timing.", isScam: false),
  ScamQuestion(message: "📱 Click link to verify phone number.", isScam: true),
  ScamQuestion(message: "👩 Mom asking to come home early.", isScam: false),
  ScamQuestion(message: "🏦 Bank asking ATM pin.", isScam: true),
  ScamQuestion(message: "🎮 Friend invites you to game.", isScam: false),
  ScamQuestion(message: "🛍️ 90% discount only today!", isScam: true),
  ScamQuestion(message: "📞 Relative calling from saved contact.", isScam: false),
  ScamQuestion(message: "🔔 Account suspended warning.", isScam: true),

  ScamQuestion(message: "🎉 You are selected for scholarship prize!", isScam: true),
  ScamQuestion(message: "📚 School exam schedule message.", isScam: false),
  ScamQuestion(message: "🧾 Pay tax fine immediately.", isScam: true),
  ScamQuestion(message: "👨‍👩‍👧 Parent asking dinner preference.", isScam: false),
  ScamQuestion(message: "🎮 Free diamonds link.", isScam: true),
  ScamQuestion(message: "📦 Order delivery confirmation.", isScam: false),
  ScamQuestion(message: "🔑 Reset password link from unknown sender.", isScam: true),
  ScamQuestion(message: "🚌 School bus timing update.", isScam: false),
  ScamQuestion(message: "💰 You earned bonus money.", isScam: true),
  ScamQuestion(message: "🎂 Birthday reminder from family.", isScam: false),
];
