import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElderScamScanner extends StatefulWidget {
  const ElderScamScanner({super.key});

  @override
  State<ElderScamScanner> createState() => _ElderScamScannerState();
}

class _ElderScamScannerState extends State<ElderScamScanner> {
  final TextEditingController controller = TextEditingController();
  String result = "";

  void scanMessage() {
    final text = controller.text.toLowerCase();

    // 🔑 Common scam-related keywords
    // Master prompt engineering, LLMs & Agentic AI in 16 weeks with live Purdue classes. Enroll now! https://simplimsg.com/SIMPLI/A4I1SV
    // -Simplilearn
    final scamKeywords = [
      "otp",
      "one time password",
      "prize",
      "won",
      "win",
      "winner",
      "lottery",
      "free",
      "claim",
      "urgent",
      "verify",
      "code",
      "bank",
      "account",
      "click",
      "link",
      "offer",
      "reward"
      "congratulations",
    ];

    bool isScam = false;

    for (var keyword in scamKeywords) {
      if (text.contains(keyword)) {
        isScam = true;
        break;
      }
    }

    if (isScam) {
      result = "🚨 WARNING: This message looks like a SCAM!";
    } else {
      result = "✅ This message seems SAFE.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: const Text("📩 Scam Message Scanner"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            /// 🔹 Input Box
            Text(
              "Paste the message you received",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: controller,
              maxLines: 5,
              enableInteractiveSelection: true, // ✅ PASTE ENABLED
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: GoogleFonts.poppins(fontSize: 18),
              decoration: InputDecoration(
                hintText: "Paste the message here",
                hintStyle: GoogleFonts.poppins(fontSize: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 Scan Button
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: scanMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  "Scan Message",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 Result
            if (result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: result.contains("SCAM")
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  result,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: result.contains("SCAM")
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
