import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/providers/register_provider.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                    Text(
                      'Registratin Successful!',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildInstructionItem('1.',
                  'Download Receipt or Take a screen shot of ', 'QR code'),
              const SizedBox(height: 15),
              _buildInstructionItem(
                  '2.', 'Visit nearest ', 'Municipal council.'),
              const SizedBox(height: 15),
              _buildInstructionItem(
                  '3.', 'Provide image and receive login password', ''),
              const SizedBox(height: 40),
              Center(
                child: Consumer<RegistrationProvider>(
                  builder: (context, registrationProvider, child) {
                    final ref = registrationProvider
                            .registrationResponse?.referenceId
                            .toString() ??
                        '';

                    String formatReferenceNumber(String reference) {
                      if (reference.isEmpty) return 'XXXX XXXX XXXX XXXX';
                      final paddedRef = reference.padLeft(4, '0');
                      final lastFour =
                          paddedRef.substring(paddedRef.length - 4);
                      return 'XXXX XXXX XXXX $lastFour';
                    }

                    return Column(
                      children: [
                        const Icon(Icons.qr_code_2,
                            size: 120, color: Colors.black),
                        const SizedBox(height: 20),
                        const Text(
                          'Reference Number',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          formatReferenceNumber(ref),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Download Receipt',
                backgroundColor: primaryColor,
                textColor: blackPrimary,
                onPressed: () {
                  // Handle download receipt action
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const NextScreen()),
                  // );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'Go to Login',
                  backgroundColor: blackPrimary,
                  textColor: whitePrimary,
                  onPressed: () {
                    Provider.of<RegistrationProvider>(context, listen: false).clearRegistrationData();
                    Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false, 
                  );
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String number, String text1, String boldText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number,
            style: const TextStyle(
                color: blackPrimary, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                  color: blackPrimary, fontSize: 14, height: 1.5),
              children: [
                TextSpan(text: text1),
                TextSpan(
                  text: boldText,
                  style: const TextStyle(
                    color: blackPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isReference = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: isReference ? 18 : 16,
            fontWeight: FontWeight.bold,
            letterSpacing: isReference ? 2.0 : 0.5,
          ),
        ),
      ],
    );
  }
}
