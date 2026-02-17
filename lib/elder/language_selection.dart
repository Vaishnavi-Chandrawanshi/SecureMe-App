import 'package:flutter/material.dart';
import 'elder_dashboard.dart';
import 'language_controller.dart';
import 'language_strings.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🌐 ${ElderTexts.t("selectLanguage")}"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _langButton(context, "English", "en"),
            _langButton(context, "हिंदी", "hi"),
            _langButton(context, "मराठी", "mr"),
          ],
        ),
      ),
    );
  }

  Widget _langButton(BuildContext context, String label, String code) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            AppLanguage.current.value = code;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ElderDashboard(),
              ),
            );
          },
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
