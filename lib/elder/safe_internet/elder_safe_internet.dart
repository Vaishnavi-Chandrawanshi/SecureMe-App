import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language_controller.dart';
import '../language_strings.dart';
import 'elder_safe_tips_data.dart';

class ElderSafeInternetScreen extends StatefulWidget {
  const ElderSafeInternetScreen({super.key});

  @override
  State<ElderSafeInternetScreen> createState() =>
      _ElderSafeInternetScreenState();
}

class _ElderSafeInternetScreenState extends State<ElderSafeInternetScreen> {
  final FlutterTts _tts = FlutterTts();

  bool _isReadingAll = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _setupTts();
  }

  Future<void> _setupTts() async {
    final lang = AppLanguage.current.value;

    await _tts.setLanguage(
      lang == "hi"
          ? "hi-IN"
          : lang == "mr"
          ? "mr-IN"
          : "en-IN",
    );

    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    // ✅ CRITICAL FIX
    await _tts.awaitSpeakCompletion(true);
  }

  Future<void> _speakSingle(String text) async {
    _isReadingAll = false;
    await _tts.stop();
    await _tts.speak(text);
  }

  // ✅ CORRECT sequential reading
  Future<void> _speakAll(List<String> tips) async {
    _isReadingAll = true;
    await _tts.stop();

    for (final tip in tips) {
      if (!_isReadingAll || _isDisposed) break;
      await _tts.speak(tip); // waits till finished
    }
  }

  void _stopSpeaking() {
    _isReadingAll = false;
    _tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _stopSpeaking();
        return true;
      },
      child: ValueListenableBuilder<String>(
        valueListenable: AppLanguage.current,
        builder: (context, lang, _) {
          final tips = elderSafeInternetTips[lang]!;

          return Scaffold(
            appBar: AppBar(
              title: Text("🛡️ ${ElderTexts.t("safeInternetTitle")}"),
              backgroundColor: Colors.teal,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    ElderTexts.t("safeInternetDesc"),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: tips.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.security,
                                  size: 36, color: Colors.teal),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  tips[index],
                                  style:
                                  GoogleFonts.poppins(fontSize: 18),
                                ),
                              ),
                              IconButton(
                                icon:
                                const Icon(Icons.volume_up),
                                color: Colors.teal,
                                iconSize: 32,
                                onPressed: () =>
                                    _speakSingle(tips[index]),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _speakAll(tips),
                          icon:
                          const Icon(Icons.play_arrow),
                          label: Text(
                              "🔊 ${ElderTexts.t("listenAll")}"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _stopSpeaking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding:
                          const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                        ),
                        child: const Icon(Icons.stop),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _stopSpeaking();
    super.dispose();
  }
}
