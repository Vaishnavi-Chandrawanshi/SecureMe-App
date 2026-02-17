import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_model.dart';

class QuizFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QuizQuestion>> fetchRandomQuestions({int count = 5}) async {
    try {
      final snapshot =
      await _firestore.collection('kids_quiz_questions').get();

      final questions = snapshot.docs
          .map((doc) {
        try {
          final q = QuizQuestion.fromFirestore(
            doc.data() as Map<String, dynamic>,
          );

          // ✅ FILTER INVALID QUESTIONS
          if (q.question.trim().isEmpty ||
              q.options.isEmpty ||
              q.options.length < 2) {
            return null;
          }

          return q;
        } catch (_) {
          return null;
        }
      })
          .whereType<QuizQuestion>()
          .toList();

      if (questions.isEmpty) return [];

      questions.shuffle();
      return questions.take(count).toList();
    } catch (e) {
      print("❌ QUIZ ERROR: $e");
      return [];
    }
  }
}