import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/custom_button.dart';
import '../../Components/otp_box.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _loginWithoutOtp = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Image.asset(
                  'assets/images/logo/logo.png', 
                  width: width*0.8,
                  height: height*0.2,                
                ),
                const SizedBox(height: 18),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: blackPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _buildOtpSection(label: 'OTP from Email'),
                const SizedBox(height: 20),
                const Divider(
                  color: greyTextColor, 
                  thickness: 1, 
                ),
                const SizedBox(height: 20),
                _buildOtpSection(label: 'OTP from Phone'),

                const SizedBox(height: 30),
                _buildLoginWithoutOtpCheckbox(),
                const SizedBox(height: 35),
                CustomButton(
                  text: 'Login',
                  backgroundColor: primaryColor,
                  textColor: blackPrimary,
                  onPressed: () {
                    // Handle login action
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildOtpSection({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            label,
            style: const TextStyle(color: greyTextColor),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => OTPBox(context: context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginWithoutOtpCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _loginWithoutOtp,
          onChanged: (value) {
            setState(() {
              _loginWithoutOtp = value!;
            });
          },
          checkColor: blackPrimary,
          activeColor: primaryColorLight,
          side: const BorderSide(color: greyTextColor),
        ),
        const Text(
          'Login without OTP next time',
          style: TextStyle(color: blackPrimary),
        )
      ],
    );
  }
}



