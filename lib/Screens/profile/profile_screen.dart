import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:gov_connect_app/providers/language_provider.dart'; // Adjust path

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLang = languageProvider.language;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: blackPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('back', style: TextStyle(color: blackPrimary, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: Text(
                      'N',
                      style: TextStyle(color: primaryColor, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nirman Perera',
                    style: TextStyle(color: blackPrimary, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'NIC - 200058413608',
                        style: TextStyle(color: greyTextColor, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                          SizedBox(width: 8),
                          Text(' verified', style: TextStyle(color: Colors.green, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Change Language',
              style: TextStyle(color: greyTextColor, fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildLanguageToggle(context, 'English', 'english', currentLang),
            const SizedBox(height: 12),
            _buildLanguageToggle(context, 'සිංහල', 'sinhala', currentLang),
            const SizedBox(height: 12),
            _buildLanguageToggle(context, 'தமிழ்', 'tamil', currentLang),
            const Spacer(),
            CustomButton(
              text: 'Update',
              backgroundColor: primaryColor,
              textColor: blackPrimary,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(
      BuildContext context, String label, String langCode, String currentLang) {
    final isSelected = currentLang == langCode;
    return GestureDetector(
      onTap: () {
        Provider.of<LanguageProvider>(context, listen: false).setLanguage(langCode);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : lightGreyColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : greyTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
