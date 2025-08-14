import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/onboarding/splash_screen.dart';
import 'package:gov_connect_app/providers/auth_provider.dart';
import 'package:gov_connect_app/providers/doc_upload_provider.dart';
import 'package:gov_connect_app/providers/register_provider.dart';
import 'package:gov_connect_app/providers/service_provider.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider<RegistrationProvider>(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider<DocUploadProvider>(create: (context) => DocUploadProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        ChangeNotifierProvider<ServiceProvider>(create:  (context) => ServiceProvider()),
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
          home: const SplashScreen(),
        );
      },
    );
  }
}






