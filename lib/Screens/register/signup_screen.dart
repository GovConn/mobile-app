import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/custom_button.dart';
import '../../Components/upload_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Image.asset(
                  'assets/images/logo/logo.png', 
                  width: width*0.8,
                  height: height*0.2,                
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: blackPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(label: 'NIC Number'),
                const SizedBox(height: 30),
                const UploadButton(label: 'Clear images of NIC - Front'),
                const SizedBox(height: 20),
                const UploadButton(label: 'Clear images of NIC - Front'),
                const SizedBox(height: 40),
                _buildInfoText(),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Next',
                  backgroundColor: primaryColor,
                  textColor: blackPrimary,
                  onPressed: () {
                    // Handle next action
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const NextScreen()),
                    // );
                  },
                ),
                const SizedBox(height: 20),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({required String label}) {
    return TextField(
      style: const TextStyle(color: blackPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: greyTextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greyTextColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blackPrimary),
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          style: TextStyle(color: blackPrimary, fontSize: 14, height: 1.5),
          children: [
            TextSpan(text: 'You will need to visit your nearest '),
            TextSpan(
              text: 'Municipal council',
              style: TextStyle(
                color: blackPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: ' to validate and receive the password'),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return const Center(
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: blackPrimary, fontSize: 12),
          children: [
            TextSpan(text: 'Have a validated account? '),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              // Add recognizer for tap event
            ),
          ],
        ),
      ),
    );
  }
}

