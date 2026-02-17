import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';


import 'elder/elder_dashboard.dart';
import 'elder/language_selection.dart';
import 'kids/kids_dashboard.dart';
import 'info/digital_safety_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SecureMeApp());
}

class SecureMeApp extends StatelessWidget {
  const SecureMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const UserSelectionScreen(),
    );
  }
}

/* -------------------- HOME SCREEN -------------------- */

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAFBF7),
              Color(0xFFFFFFFF),
              Color(0xFFF6F2FF),
            ],
          ),
        ),
        child: Stack(
          children: [

            /// ℹ️ INFO BUTTON (NEW)
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.info_outline),
                iconSize: 30,
                color: Colors.teal,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DigitalSafetyInfoScreen(),
                    ),
                  );
                },
              ),
            ),

            // 🎮 Kids-style background
            Positioned(
              top: 40,
              left: 20,
              child: Icon(Icons.directions_car,
                  size: 80, color: Colors.orange.withOpacity(0.15)),
            ),
            Positioned(
              top: 140,
              left: 60,
              child: Icon(Icons.star,
                  size: 60, color: Colors.orange.withOpacity(0.12)),
            ),

            // 🌿 Elderly-style background
            Positioned(
              bottom: 120,
              right: 40,
              child: Icon(Icons.local_florist,
                  size: 70, color: Colors.blue.withOpacity(0.15)),
            ),
            Positioned(
              bottom: 40,
              right: 90,
              child: Icon(Icons.circle,
                  size: 60, color: Colors.blue.withOpacity(0.1)),
            ),

            // 🔐 Main Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.shield_rounded,
                        size: 80, color: Colors.teal),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "SecureMe",
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Smart Digital Safety Learning for Kids & Elderly",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Choose how you want to use the app",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Kids Mode
                  _modeButton(
                    title: "Kids Mode",
                    subtitle: "Games • Stories • Safe Learning",
                    icon: Icons.child_care_rounded,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const KidsDashboard()),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  // Elderly Mode
                  _modeButton(
                    title: "Elderly Mode",
                    subtitle: "Scam Protection • Simple Guidance",
                    icon: Icons.elderly_rounded,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LanguageSelectionScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2),
              ),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
