import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_details_screen.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_rating_screen.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_service_screen.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_status.dart';
import 'package:gov_connect_app/Screens/Appointment/pending_screen.dart';
import 'package:gov_connect_app/Screens/Appointment/resrevation_screen.dart';
import 'package:gov_connect_app/Screens/home/home_screen.dart';
import 'package:gov_connect_app/Screens/login/change_password_screen.dart';
import 'package:gov_connect_app/Screens/login/login_otp_screen.dart';
import 'package:gov_connect_app/Screens/login/login_screen.dart';
import 'package:gov_connect_app/Screens/onboarding/splash_screen.dart';
import 'package:gov_connect_app/Screens/profile/history_screen.dart';
import 'package:gov_connect_app/Screens/profile/notification_screen.dart';
import 'package:gov_connect_app/Screens/profile/profile_screen.dart';
import 'package:gov_connect_app/Screens/register/email_otp_signup_screen.dart';
import 'package:gov_connect_app/Screens/register/phone_otp_signup_screen.dart';
import 'package:gov_connect_app/Screens/register/register_success_screen.dart';
import 'package:gov_connect_app/Screens/register/signup_screen.dart';
import 'package:gov_connect_app/Screens/services/eservices_screen.dart';
import 'package:provider/provider.dart';

import 'Screens/Appointment/confirmation_screen.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),
      ],
      builder: (context, child) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        final textTheme = languageProvider.getTextTheme(context);

        return MaterialApp(
          title: 'GovConnect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
            useMaterial3: true,
            textTheme: textTheme,
          ),
          home: EServicesScreen(),
        );
      },
    );
  }
}






