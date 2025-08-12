import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/Components/logo_banner.dart';
import 'package:gov_connect_app/Components/otp_box.dart';
import 'package:gov_connect_app/Components/toast_message.dart';
import 'package:gov_connect_app/Screens/register/phone_otp_signup_screen.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';

class EmailOTPSignupScreen extends StatefulWidget {
  const EmailOTPSignupScreen({super.key});

  @override
  State<EmailOTPSignupScreen> createState() => _EmailOTPSignupScreenState();
}

class _EmailOTPSignupScreenState extends State<EmailOTPSignupScreen> {
   final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());
  bool _otpSent = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    setState(() {
      if (email.isEmpty) {
        _emailError = null;
      } else if (!_isValidEmail(email)) {
        _emailError = 'Enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _isOtpComplete() {
    return _otpSent && _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _sendOtp() {
    final email = _emailController.text.trim();
    
    if (email.isEmpty) {
      setState(() => _emailError = 'Email cannot be empty');
      ToastMessage.showError(context,'Please enter your email');
      return;
    }
    
    if (!_isValidEmail(email)) {
      setState(() => _emailError = 'Enter a valid email address');
      ToastMessage.showError(context,'Please enter a valid email');
      return;
    }

    Provider.of<RegistrationProvider>(context, listen: false).setEmail(email);
    
    final randomOtp = List.generate(5, (index) => (index + 1).toString()).join();
    for (int i = 0; i < 5; i++) {
      _otpControllers[i].text = randomOtp[i];
    }

    setState(() => _otpSent = true);
    ToastMessage.showSuccess(context,'OTP sent to your email');
  }

  void _verifyEmail() {
    final registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);
    if (!_otpSent) {
      ToastMessage.showError(context,'Please get OTP first');
      return;
    }

    if (!_isOtpComplete()) {
      ToastMessage.showError(context,'Please enter complete OTP');
      return;
    }
    registrationProvider.setEmail(_emailController.text.trim());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneOTPSignupscreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }


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
                _buildTextField(label: 'Register an email'),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Send OTP',
                  backgroundColor:  primaryColor,
                  textColor: blackPrimary,
                  onPressed: _sendOtp        
                ),
                const SizedBox(height: 40),
                _buildOtpSection(label: 'OTP from Email'),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Verify Email',
                  backgroundColor: blackPrimary,
                  textColor: whitePrimary,
                  onPressed: _verifyEmail,
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
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        hintText: 'example@domain.com',
        errorText: _emailError,
        labelStyle: const TextStyle(color: Colors.black54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blackPrimary),      
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
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
}
