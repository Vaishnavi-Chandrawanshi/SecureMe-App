import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'progress_firebase_service.dart';

class SafetyStoriesScreen extends StatefulWidget {
  const SafetyStoriesScreen({super.key});

  @override
  State<SafetyStoriesScreen> createState() => _SafetyStoriesScreenState();
}

class _SafetyStoriesScreenState extends State<SafetyStoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      appBar: AppBar(
        title: const Text("📖 Safety Stories"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          StoryCard(
            title: "The Secret Password Tree",
            color: Colors.orange,
            story:
            "Once upon a time, in a colorful village, there lived a boy named Raju.\n\n"
                "Raju had a magic tablet that opened only with a secret password.\n\n"
                "One day, his friend asked him to share it.\n\n"
                "Raju smiled and said, passwords are like keys. We never give keys to others.",
            moral: "Passwords are secret. Never share them with anyone.",
          ),
          StoryCard(
            title: "The Stranger in the Game",
            color: Colors.purple,
            story:
            "Once upon a time, Meena loved playing online games.\n\n"
                "One day, a stranger started asking personal questions.\n\n"
                "Meena closed the chat and told her mother immediately.",
            moral: "Never chat with strangers online. Always tell an adult.",
          ),
          StoryCard(
            title: "The Fake Prize Message",
            color: Colors.redAccent,
            story:
            "Once upon a time, Aarav received a message saying he won a phone.\n\n"
                "Instead of clicking the link, he showed it to his father.\n\n"
                "It turned out to be a fake prize.",
            moral: "Do not click unknown links or prize messages.",
          ),
          StoryCard(
            title: "The Safe App Shop",
            color: Colors.blue,
            story:
            "Once upon a time, Kavya wanted a new game.\n\n"
                "She found it on a strange website but felt unsure.\n\n"
                "She asked her parents and used the app store safely.",
            moral: "Download apps only from trusted app stores.",
          ),
          StoryCard(
            title: "CyberBot the Helper",
            color: Colors.green,
            story:
            "Once upon a time, CyberBot helped kids stay safe online.\n\n"
                "He reminded them to lock devices and update apps.\n\n"
                "Kids who listened stayed protected and happy.",
            moral: "Technology is safe when used wisely.",
          ),
        ],
      ),
    );
  }
}

/* ===================== STORY CARD ===================== */

class StoryCard extends StatefulWidget {
  final String title;
  final String story;
  final String moral;
  final Color color;

  const StoryCard({
    super.key,
    required this.title,
    required this.story,
    required this.moral,
    required this.color,
  });

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  final FlutterTts _tts = FlutterTts();
  final ProgressFirebaseService _progressService =
  ProgressFirebaseService();

  bool isPlaying = false;
  bool hasCounted = false; // ✅ prevents multiple increments

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.1);
    await _tts.setVolume(1.0);

    _tts.setCompletionHandler(() {
      setState(() => isPlaying = false);
    });
  }

  Future<void> playStory() async {
    await _tts.stop();
    setState(() => isPlaying = true);

    // ✅ UPDATE FIREBASE ONLY ONCE
    if (!hasCounted) {
      await _progressService.incrementStoryRead();
      hasCounted = true;
    }

    await _tts.speak("${widget.story}. Moral: ${widget.moral}");
  }

  Future<void> stopStory() async {
    await _tts.stop();
    setState(() => isPlaying = false);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.story,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "🌟 Moral: ${widget.moral}",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: playStory,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Play Story"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: widget.color,
                ),
              ),
              const SizedBox(width: 10),
              if (isPlaying)
                ElevatedButton.icon(
                  onPressed: stopStory,
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.15);
  }
}
