import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafeInternetScreen extends StatelessWidget {
  const SafeInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌐 Safe Net Rules"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFE8F5E9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.95,
            children: const [
              SafeRuleCard(
                icon: Icons.lock,
                title: "Strong Passwords",
                description:
                "Use strong passwords and never share them with anyone.",
                color: Colors.orange,
              ),
              SafeRuleCard(
                icon: Icons.visibility_off,
                title: "Privacy First",
                description:
                "Keep your personal details private on the internet.",
                color: Colors.purple,
              ),
              SafeRuleCard(
                icon: Icons.people,
                title: "Stranger Alert",
                description:
                "Do not chat with strangers online. Tell an adult.",
                color: Colors.redAccent,
              ),
              SafeRuleCard(
                icon: Icons.schedule,
                title: "Screen Time",
                description:
                "Limit screen time and take regular breaks.",
                color: Colors.green,
              ),
              SafeRuleCard(
                icon: Icons.download,
                title: "Safe Downloads",
                description:
                "Download apps only from trusted app stores.",
                color: Colors.blue,
              ),
              SafeRuleCard(
                icon: Icons.warning_amber,
                title: "Scam Awareness",
                description:
                "Ignore prize messages and suspicious links.",
                color: Colors.deepOrange,
              ),
              SafeRuleCard(
                icon: Icons.security,
                title: "App Permissions",
                description:
                "Check app permissions before allowing access.",
                color: Colors.teal,
              ),
              SafeRuleCard(
                icon: Icons.report,
                title: "Report Problems",
                description:
                "Report cyberbullying or bad content immediately.",
                color: Colors.indigo,
              ),
              SafeRuleCard(
                icon: Icons.public_off,
                title: "Location Safety",
                description:
                "Do not share your live location online.",
                color: Colors.brown,
              ),
              SafeRuleCard(
                icon: Icons.thumb_up,
                title: "Be Kind Online",
                description:
                "Use polite words and respect others online.",
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== RULE CARD ===================== */

class SafeRuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const SafeRuleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 42, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
