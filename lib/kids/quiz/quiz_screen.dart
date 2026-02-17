import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_model.dart';
import 'quiz_firebase_service.dart';
import '../progress_firebase_service.dart'; // ✅ ADD THIS

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> quizQuestions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final service = QuizFirebaseService();

    List<QuizQuestion> data = [];
    try {
      data = await service.fetchRandomQuestions();
    } catch (e) {
      print("❌ LOAD ERROR: $e");
    }

    if (!mounted) return;

    setState(() {
      quizQuestions = data;
      isLoading = false; // ✅ ALWAYS SET FALSE
    });
  }

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == quizQuestions[currentIndex].correctIndex) {
      score++;
    }
    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (currentIndex >= quizQuestions.length) {
      return _resultScreen();
    }

    final question = quizQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("🧠 Fun Safety Quiz"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2F7FF),
              Color(0xFFEAF4FF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Question ${currentIndex + 1} / ${quizQuestions.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: question.color,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: question.color.withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Text(
                  question.question,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 34),
              ...List.generate(question.options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueGrey.shade900,
                      elevation: 5,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      question.options[index],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// 🎉 RESULT SCREEN
  Widget _resultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎉 Result"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEAFBEF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events,
                  size: 110, color: Colors.orange),
              const SizedBox(height: 20),
              Text(
                "You scored $score / ${quizQuestions.length}",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              /// ✅ ONLY CHANGE IS HERE
              ElevatedButton.icon(
                onPressed: () async {
                  final progressService = ProgressFirebaseService();
                  await progressService.incrementQuizCompleted();

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Play Again"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
