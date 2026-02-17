import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 📱 Single-device demo user
  final String userId = "demo_user";

  /// 🔹 Fetch complete kids progress
  Future<Map<String, int>> fetchProgress() async {
    final doc =
    await _firestore.collection('users').doc(userId).get();

    final data = doc.data()?['kidsProgress'];

    if (data == null) {
      return {
        "storiesRead": 0,
        "quizzesCompleted": 0,
        "scamsAvoided": 0,
      };
    }

    return {
      "storiesRead": data['storiesRead'] ?? 0,
      "quizzesCompleted": data['quizzesCompleted'] ?? 0,
      "scamsAvoided": data['scamsAvoided'] ?? 0,
    };
  }

  /// 🧠 QUIZ COMPLETED
  Future<void> incrementQuizCompleted() async {
    final ref = _firestore.collection('users').doc(userId);

    await ref.set({
      "kidsProgress": {
        "quizzesCompleted": FieldValue.increment(1),
      }
    }, SetOptions(merge: true));
  }

  /// 📖 STORY READ
  Future<void> incrementStoryRead() async {
    final ref = _firestore.collection('users').doc(userId);

    await ref.set({
      "kidsProgress": {
        "storiesRead": FieldValue.increment(1),
      }
    }, SetOptions(merge: true));
  }

  /// 🚨 SCAM AVOIDED (SCAM GAME COMPLETED)
  Future<void> incrementScamsAvoided() async {
    final ref = _firestore.collection('users').doc(userId);

    await ref.set({
      "kidsProgress": {
        "scamsAvoided": FieldValue.increment(1),
      }
    }, SetOptions(merge: true));
  }
}
