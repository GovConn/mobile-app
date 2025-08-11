import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  Widget languageTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String btnText,
    required String langCode,
  }) {
     final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () {
            // langProvider.setLanguage(langCode);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text(
            btnText,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            languageTile(
              context: context,
              title: "Welcome",
              subtitle: "Introduce and welcome says to choose language",
              btnText: "English",
              langCode: "english",
            ),
            languageTile(
              context: context,
              title: "ආයුබෝවන්",
              subtitle: "පරිශීලක නාමය තෝරන්න සහ පිවිසෙන්න",
              btnText: "සිංහල",
              langCode: "sinhala",
            ),
            languageTile(
              context: context,
              title: "வணக்கம்",
              subtitle: "தேர்ந்தெடுக்கப்பட்ட மொழியில் அறிமுகம் மற்றும் வரவேற்பு.",
              btnText: "தமிழ்",  
              langCode: "tamil",          
            ),
          ],
        ),
      ),
    );
  }
}
