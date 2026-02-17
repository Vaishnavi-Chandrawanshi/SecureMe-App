import 'language_controller.dart';

class ElderTexts {
  static const Map<String, Map<String, String>> texts = {
    "en": {
      // Dashboard
      "title": "Elder Safety Support",
      "voice": "Voice Safety Tips",
      "scam": "Check Scam Message",
      "sos": "Emergency SOS",
      "internet": "Safe Internet",

      // Language
      "selectLanguage": "Select your language",

      // Safe Internet
      "safeInternetTitle": "Safe Internet Tips",
      "safeInternetDesc": "Follow these simple rules to stay safe online",
      "listenAll": "Listen All Tips",
      "alwaysAlert": "Always be alert. If unsure, ask a family member.",

      // Scam Scanner
      "scamTitle": "Scam Message Scanner",
      "scamHint": "Paste the message here",
      "scanBtn": "Scan Message",
      "scamWarning": "🚨 WARNING: This message looks like a SCAM!",
      "scamSafe": "✅ This message seems SAFE.",

      // SOS
      "sosTitle": "Emergency SOS",
      "sosDesc": "Tap below to call for help",

    },

    "hi": {
      // Dashboard
      "title": "वरिष्ठ सुरक्षा सहायता",
      "voice": "आवाज सुरक्षा टिप्स",
      "scam": "धोखाधड़ी संदेश जांचें",
      "sos": "आपातकालीन SOS",
      "internet": "सुरक्षित इंटरनेट",


      // Language
      "selectLanguage": "अपनी भाषा चुनें",

      // Safe Internet
      "safeInternetTitle": "सुरक्षित इंटरनेट सुझाव",
      "safeInternetDesc": "ऑनलाइन सुरक्षित रहने के लिए इन नियमों का पालन करें",
      "listenAll": "सभी सुझाव सुनें",
      "alwaysAlert": "हमेशा सतर्क रहें। संदेह हो तो परिवार से पूछें।",

      // Scam Scanner
      "scamTitle": "धोखाधड़ी संदेश जांच",
      "scamHint": "संदेश यहां पेस्ट करें",
      "scanBtn": "संदेश जांचें",
      "scamWarning": "🚨 चेतावनी: यह संदेश धोखाधड़ी हो सकता है!",
      "scamSafe": "✅ यह संदेश सुरक्षित लगता है।",

      // SOS
      "sosTitle": "आपातकालीन SOS",
      "sosDesc": "मदद के लिए नीचे टैप करें",

    },

    "mr": {
      // Dashboard
      "title": "ज्येष्ठ नागरिक सुरक्षा",
      "voice": "आवाज सुरक्षा टिप्स",
      "scam": "फसवणूक संदेश तपासा",
      "sos": "आपत्कालीन SOS",
      "internet": "सुरक्षित इंटरनेट",


      // Language
      "selectLanguage": "भाषा निवडा",

      // Safe Internet
      "safeInternetTitle": "सुरक्षित इंटरनेट सूचना",
      "safeInternetDesc": "ऑनलाइन सुरक्षित राहण्यासाठी हे नियम पाळा",
      "listenAll": "सर्व सूचना ऐका",
      "alwaysAlert": "नेहमी सावध रहा. शंका असल्यास कुटुंबाला विचारा.",

      // Scam Scanner
      "scamTitle": "फसवणूक संदेश तपासणी",
      "scamHint": "संदेश येथे पेस्ट करा",
      "scanBtn": "संदेश तपासा",
      "scamWarning": "🚨 इशारा: हा संदेश फसवणूक असू शकतो!",
      "scamSafe": "✅ हा संदेश सुरक्षित वाटतो.",

      // SOS
      "sosTitle": "आपत्कालीन SOS",
      "sosDesc": "मदतीसाठी खाली टॅप करा",

    },
  };

  static String t(String key) {
    return texts[AppLanguage.current.value]![key]!;
  }
}
