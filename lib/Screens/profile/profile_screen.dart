import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov_connect_app/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:gov_connect_app/providers/language_provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).fetchUser().catchError((error) {
         debugPrint("Failed to fetch user: $error");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              'Back',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isUserLoading) {
            return const Center(child: 
            SpinKitSpinningLines(
              color: primaryColor,
            ));
          }

          // 2. Error State
          if (authProvider.user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    authProvider.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    textColor: Colors.white,
                    text: 'Retry',
                    onPressed: () => authProvider.fetchUser(),
                    backgroundColor: blackPrimary,
                  ),
                ],
              ),
            );
          }

          if (authProvider.user != null) {
            return _buildProfileContent(context, authProvider.user!);
          }
          return const Center(child: Text('Something went wrong. Please restart the app.'));
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserModel user) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  child: Text(
                    user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : 'U',
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                      color: blackPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildVerificationStatus(user.active),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          const Text(
            'Personal Information',
            style: TextStyle(color: greyTextColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildDetailRow(Icons.credit_card, 'NIC', user.nic),
          const Divider(),
          // Assuming User model has email and phone fields
          _buildDetailRow(Icons.email, 'Email', user.email),
          const Divider(),
          _buildDetailRow(Icons.phone, 'Phone', user.phone),
          
          const SizedBox(height: 30),

          // Section for Language Dropdown
          const Text(
            'Change Language',
            style: TextStyle(color: greyTextColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildLanguageDropdown(context, languageProvider),
          
          const Spacer(),
          CustomButton(
            text: 'Logout',
            backgroundColor: primaryColor,
            textColor: blackPrimary,
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            },
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
  
  Widget _buildVerificationStatus(bool isActive) {
      final color = isActive ? Colors.green : Colors.red;
      final text = isActive ? 'Verified' : 'Not Verified';
      final icon = isActive ? Icons.check_circle : Icons.cancel;

      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(text, style: TextStyle(color: color, fontSize: 12)),
          ],
      );
  }
  
  
  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: greyTextColor, size: 20),
          const SizedBox(width: 16),
          Text(
            '$title: ',
            style: const TextStyle(color: blackPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: greyTextColor, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  

  Widget _buildLanguageDropdown(BuildContext context, LanguageProvider languageProvider) {
    final Map<String, String> languages = {
      'english': 'English',
      'sinhala': 'සිංහල',
      'tamil': 'தமிழ்',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageProvider.language,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: greyTextColor),
          items: languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: (String? newLanguage) {
            if (newLanguage != null) {
              languageProvider.setLanguage(newLanguage);
            }
          },
        ),
      ),
    );
  }
}