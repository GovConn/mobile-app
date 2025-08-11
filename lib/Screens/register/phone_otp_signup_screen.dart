import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/Components/logo_banner.dart';
import 'package:gov_connect_app/Components/otp_box.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

class PhoneOTPSignupscreen extends StatefulWidget {
  const PhoneOTPSignupscreen({super.key});

  @override
  State<PhoneOTPSignupscreen> createState() => _PhoneOTPSignupscreenState();
}

class _PhoneOTPSignupscreenState extends State<PhoneOTPSignupscreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                LogoBanner( 
                  width: width * 0.8,
                  height: height * 0.2,
                  ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(label: 'Register a Phone Number'),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Send OTP',
                  backgroundColor: primaryColor,
                  textColor: blackPrimary,
                  onPressed: () {
                    // Handle send OTP action
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const NextScreen()),
                    // );
                  },
                ),
                const SizedBox(height: 40),
                _buildOtpSection(label: 'OTP from Phone'),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Verify Phone',
                  backgroundColor: blackPrimary,
                  textColor: whitePrimary,
                  onPressed: () {
                    // Handle verify email action
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const NextScreen()),
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

  Widget _buildTextField({required String label}) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildOtpSection({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: greyTextColor),
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

  Widget _buildOtpBox() {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          maxLength: 1,
        ),
      ),
    );
  }

}
