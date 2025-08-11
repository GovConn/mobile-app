import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/login/login_screen.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height*0.02, horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                Image.asset(
                  'assets/images/logo/logo.png', 
                  width: width*0.8,
                  height: height*0.2,                
                ),
                SizedBox(height: height * 0.015),
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
                SizedBox(height: height * 0.02),
                _buildTextField(label: 'NIC Number'),
                SizedBox(height: height * 0.03),
                const UploadButton(label: 'Clear images of NIC - Front'),
                SizedBox(height: height * 0.02),
                const UploadButton(label: 'Clear images of NIC - Front'),
                SizedBox(height:height * 0.04),
                _buildInfoText(),
                SizedBox(height: height * 0.06),
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
                SizedBox(height: height * 0.03),
                _buildLoginLink(context),
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

  Widget _buildLoginLink(BuildContext context) {
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Have a validated account? ',
          style: TextStyle(color: blackPrimary, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
}

