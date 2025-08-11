import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/Screens/register/signup_screen.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height*0.0275, horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.02),
                Image.asset(
                  'assets/images/logo/logo.png', 
                  width: width*0.8,
                  height: height*0.2,                
                ),
                SizedBox(height: height * 0.02),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: blackPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.0275),
                _buildTextField(label: 'NIC Number'),
                SizedBox(height: height * 0.025),
                _buildTextField(label: 'Password', obscureText: true),
                SizedBox(height: height * 0.035),
                _buildCaptcha(),
                SizedBox(height: height * 0.05),
                CustomButton(
                    text: 'Submit',
                    backgroundColor: primaryColor,
                    textColor: blackPrimary,
                    onPressed: () {
                      // Handle login action
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                      // );
                    }),
                SizedBox(height: height * 0.035),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
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

  Widget _buildCaptcha() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: greyTextColor),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value!;
              });
            },
            checkColor: blackPrimary,
            activeColor: primaryColorLight,
            side: const BorderSide(color: greyTextColor),
          ),
          const Text(
            'Captcha',
            style: TextStyle(color: blackPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: greyTextColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
