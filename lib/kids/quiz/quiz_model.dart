import 'package:flutter/material.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final Color color;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.color,
  });

  /// 🔥 Factory from Firebase
  factory QuizQuestion.fromFirestore(Map<String, dynamic> data) {
    final rawOptions = data['options'];

    // ✅ SAFETY CHECK
    final List<String> options = rawOptions is List
        ? rawOptions.map((e) => e.toString()).toList()
        : [];

    if (options.isEmpty) {
      return QuizQuestion(
        question: data['question'] ?? '',
        options: const ['OK'],
        correctIndex: 0,
        color: _getColor(data['color'] ?? ''),
      );
    }

    int correctIndex =
    options.indexOf(data['correctAnswer']);

    if (correctIndex == -1) {
      correctIndex = 0;
    }

    return QuizQuestion(
      question: data['question'] ?? '',
      options: options,
      correctIndex: correctIndex,
      color: _getColor(data['color'] ?? ''),
    );
  }

  /// 🎨 Convert string → Color
  static Color _getColor(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.cyan;
    }
  }
}
