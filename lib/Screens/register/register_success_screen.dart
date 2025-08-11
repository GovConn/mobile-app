import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

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
                child: Text(
                  'Success!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildInstructionItem('1.', 'Download or take a screen shot of ', 'this page.'),
              const SizedBox(height: 15),
              _buildInstructionItem('2.', 'Go to your nearest ', 'Municipal council.'),
              const SizedBox(height: 15),
              _buildInstructionItem('3.', 'Provide ', 'them the image and receive the login password.'),
              const SizedBox(height: 40),
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.qr_code_2, size: 120, color: Colors.black),
                    SizedBox(height: 20),
                    Text(
                      'Reference Number',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      'XXXX XXXX XXXX XXXX',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                    // Handle go to login action
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                    // );
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
        Text(number, style: const TextStyle(color: blackPrimary, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(color: blackPrimary, fontSize: 14, height: 1.5),
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

}