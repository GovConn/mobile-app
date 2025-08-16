import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/Components/toast_message.dart';
import 'package:gov_connect_app/Screens/register/signup_screen.dart';
import 'package:gov_connect_app/providers/auth_provider.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nicController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  String? _nicError;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.0275, horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.02),
                Image.asset(
                  'assets/images/logo/logo.png',
                  width: width * 0.8,
                  height: height * 0.2,
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
                _buildTextField(
                  label: 'NIC Number',
                  controller: _nicController,
                  errorText: _nicError,
                ),
                SizedBox(height: height * 0.025),
                _buildPasswordField(),
                SizedBox(height: height * 0.035),
                _buildCaptcha(),
                SizedBox(height: height * 0.05),
                CustomButton(
                  text: 'Login',
                  backgroundColor: primaryColor,
                  textColor: blackPrimary,
                  onPressed: _handleLogin,
                ),
                SizedBox(height: height * 0.035),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: blackPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: greyTextColor),
        errorText: errorText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greyTextColor),
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

  Widget _buildPasswordField() {
    return TextField(
      obscureText: _obscurePassword,
      controller: _passwordController,
      style: const TextStyle(color: blackPrimary),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: greyTextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greyTextColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: blackPrimary),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: greyTextColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
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
            'I\'m not a robot',
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

  void _handleLogin() async {
    // Validate NIC
    final nic = _nicController.text.trim();
    if (!_validateNIC(nic)) {
      setState(() {
        _nicError = 'Invalid NIC format';
      });
      return;
    } else {
      setState(() {
        _nicError = null;
      });
    }

    // Validate captcha
    if (!_rememberMe) {
      ToastMessage.showInfo(context, 'Please verify you are not a robot');
      return;
    }

    // Proceed with login
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final password = _passwordController.text.trim();
    bool success = await authProvider.login(nic, password);
    
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (mounted) {
      ToastMessage.showError(context, authProvider.errorMessage);
    }
  }

  bool _validateNIC(String nic) {
    if (nic.length == 9) {
      return nic.endsWith('V') || nic.endsWith('v');
    } else if (nic.length == 12) {
      return RegExp(r'^[0-9]+$').hasMatch(nic);
    }
    return false;
  }
}