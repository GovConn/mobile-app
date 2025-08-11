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
    required double width,
    required double height,
  }) {
     final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: height*0.035, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
       SizedBox(height: height * 0.01),
        Text(
          subtitle,
          style:  TextStyle(color: Colors.black, fontSize: height*0.0215, fontWeight: FontWeight.w400),
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
        SizedBox(height: height * 0.025),
        const Divider(thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: width*0.05,right: width*0.05, top: height*0.1, bottom: height*0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            languageTile(
              context: context,
              title: "Welcome",
              subtitle: "This is Sri Lanka's e-Government portal. Select your language.",
              btnText: "English",
              langCode: "english",
              width: width,
              height: height,
            ),
            languageTile(
              context: context,
              title: "ආයුබෝවන්",
              subtitle: "මෙය ශ්‍රී ලංකාවේ ඉ-රාජ්‍ය ද්වාරයයි. ඔබේ භාෂාව තෝරන්න.",
              btnText: "සිංහල",
              langCode: "sinhala",
              width: width,
              height: height,
            ),
            languageTile(
              context: context,
              title: "வணக்கம்",
              subtitle: "இது இலங்கையின் மின்-அரசு போர்டல். உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்.",
              btnText: "தமிழ்",  
              langCode: "tamil", 
              width: width,
              height: height,         
            ),
          ],
        ),
      ),
    );
  }
}
