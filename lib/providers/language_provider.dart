import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = "english"; 
  String get language => _language;

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  TextTheme getTextTheme(BuildContext context) {
    if (_language == "sinhala") {
      return GoogleFonts.notoSansSinhalaTextTheme(
        Theme.of(context).textTheme,
      );
    } else if (_language == "tamil") {
      return GoogleFonts.notoSansTamilTextTheme(
        Theme.of(context).textTheme,
      );
    }
    return GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
    );
  }
}
