import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/Components/logo_banner.dart';
import 'package:gov_connect_app/Components/otp_box.dart';
import 'package:gov_connect_app/Screens/register/register_success_screen.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';

import '../../Components/toast_message.dart';
import '../../providers/register_provider.dart';

class PhoneOTPSignupscreen extends StatefulWidget {
  const PhoneOTPSignupscreen({super.key});

  @override
  State<PhoneOTPSignupscreen> createState() => _PhoneOTPSignupscreenState();
}

class _PhoneOTPSignupscreenState extends State<PhoneOTPSignupscreen> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(5, (index) => TextEditingController());
  bool _otpSent = false;
  String? _phoneError;
  bool _isLoading = false;

  bool _isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phone);
  }

  bool _isOtpComplete() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      setState(() => _phoneError = 'Phone Number cannot be empty');
      ToastMessage.showError(context, 'Please enter your phone number');
      return;
    }

    if (!_isValidPhone(phone)) {
      setState(() => _phoneError = 'Enter a valid phone number');
      ToastMessage.showError(context, 'Please enter a valid phone number');
      return;
    }

    Provider.of<RegistrationProvider>(context, listen: false).setPhone(phone);

    // Generate random 5-digit OTP
    final random = Random();
    final randomOtp =
        List.generate(5, (index) => random.nextInt(10).toString()).join();

    for (int i = 0; i < 5; i++) {
      _otpControllers[i].text = randomOtp[i];
      if (i < 4) {
        FocusScope.of(context).nextFocus();
      }
    }
    setState(() => _otpSent = true);
    ToastMessage.showSuccess(context, 'OTP sent to your email');
  }

  Future<void> _verifyPhoneAndRegister() async {
  final registrationProvider = 
      Provider.of<RegistrationProvider>(context, listen: false);

  if (!_otpSent) {
    ToastMessage.showError(context, 'Please get OTP first');
    return;
  }

  if (!_isOtpComplete()) {
    ToastMessage.showError(context, 'Please enter complete OTP');
    return;
  }

  setState(() => _isLoading = true);
  
  try {
    registrationProvider.setPhone(_phoneController.text.trim());
    await registrationProvider.registerCitizen();

    if (!mounted) return;

    if (registrationProvider.status == RegistrationStatus.success) {
      ToastMessage.showSuccess(context, 'Registration Successful!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignupSuccessScreen()),
      );
    } else {
      ToastMessage.showError(
        context,
        'Registration Failed: ${registrationProvider.errorMessage}',
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

  @override
  void dispose() {
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children:[ Scaffold(
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
                        if (!_isLoading) {
                          _sendOtp();
                        }
                      }),
                  const SizedBox(height: 40),
                  _buildOtpSection(label: 'OTP from Phone'),
                  const SizedBox(height: 40),
                  CustomButton(
                      text: 'Verify Phone & Submit',
                      backgroundColor: blackPrimary,
                      textColor: whitePrimary,
                      onPressed: () {
                        if (!_isLoading) {
                          _verifyPhoneAndRegister();                      
                        }
                      }),
                  if (_isLoading) const SizedBox(height: 20),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ),
      if (_isLoading)
        GestureDetector(
          onTap: () {}, // Block interactions
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitSpinningLines(
                      color: primaryColor,
                      lineWidth: 3,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Wait for Registration...',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }

  Widget _buildTextField({required String label}) {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.black),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      decoration: InputDecoration(
        hintText: '07XXXXXXXX',
        errorText: _phoneError,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blackPrimary),
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
              (index) => OTPBox(
                context: context,
                controller: _otpControllers[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

