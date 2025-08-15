import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/home/home_screen.dart';
import 'package:gov_connect_app/Screens/onboarding/language_selection.dart';
import 'package:gov_connect_app/Screens/onboarding/splash_screen.dart';
import 'package:gov_connect_app/Screens/service_register/need_action.dart';
import 'package:gov_connect_app/Screens/service_register/uploaded.dart';
import 'package:gov_connect_app/Screens/services/eservices_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/Appointment/confirmation_screen.dart';
import 'Screens/service_register/qr_no_action.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(const MyApp());
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
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
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
          home: const UploadedScreen(),
        );
      },
    );
  }
}
