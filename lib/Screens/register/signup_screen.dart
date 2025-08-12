import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/upload_button_2.dart';
import 'package:gov_connect_app/Screens/register/email_otp_signup_screen.dart';
import 'package:gov_connect_app/providers/register_provider.dart';
import 'package:gov_connect_app/screens/login/login_screen.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';
import '../../Components/bio_data_form.dart';
import '../../components/custom_button.dart';

import '../../providers/doc_upload_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Map<String, String>? _bioData;
  String? _nicFrontUrl;
  String? _nicBackUrl;

  bool get _isBioDataSubmitted => _bioData != null;
  bool get _isNicFrontUploaded => _nicFrontUrl != null;
  bool get _isNicBackUploaded => _nicBackUrl != null;
  bool get _canProceed =>
      _isBioDataSubmitted && _isNicFrontUploaded && _isNicBackUploaded;
  String _bioDataButtonText = "Fill the bio data form";

  bool _isNicFrontLoading = false;
  bool _isNicBackLoading = false;

  Future<void> _handleUpload(String docName) async {
    final docUploadProvider =
        Provider.of<DocUploadProvider>(context, listen: false);
    final registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = File(result.files.single.path!);

    setState(() {
      if (docName == 'NICFront') {
        _isNicFrontLoading = true;
      } else if (docName == 'NICBack') {
        _isNicBackLoading = true;
      }
    });

    final String? uploadedUrl = await docUploadProvider.uploadDocument(
      file: file,
      docName: docName,
      userName: registrationProvider.firstName!,
      userNic: registrationProvider.nic!,
    );

    if (uploadedUrl != null && mounted) {
      if (docName == 'NICFront') {
        registrationProvider.setNicFrontUrl(uploadedUrl);
      } else if (docName == 'NICBack') {
        registrationProvider.setNicBackUrl(uploadedUrl);
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Upload failed: ${docUploadProvider.errorMessage ?? "Unknown error"}'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      if (docName == 'NICFront') {
        _isNicFrontLoading = false;
      } else if (docName == 'NICBack') {
        _isNicBackLoading = false;
      }
    });
  }

  Future<void> _openBioDataForm(
      RegistrationProvider registrationProvider) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const BioDataFormDialog();
      },
    );

    if (result != null) {
      setState(() {
        _bioData = result;
        _bioDataButtonText = "Bio Data Submitted";
        registrationProvider.updateBioData(
          newNic: result['nic']!,
          newFirstName: result['firstName']!,
          newLastName: result['lastName']!,
        );
      });
    } else {
      setState(() {
        _bioDataButtonText = "Insert Bio Data to Continue";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final registrationProvider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                Image.asset(
                  'assets/images/logo/logo.png',
                  width: width * 0.8,
                  height: height * 0.15,
                ),
                SizedBox(height: height * 0.015),
                const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        color: blackPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: height * 0.04),

                // Step 1: Bio Data Button
                _buildStepButton(
                  text: _bioDataButtonText,
                  isCompleted: _isBioDataSubmitted,
                  onPressed: () => _openBioDataForm(registrationProvider),
                ),
                SizedBox(height: height * 0.03),
                UploadButtonCustomized(
                  label: 'Upload NIC Front',
                  onPressed: registrationProvider.isBiodataComplete
                      ? () => _handleUpload('NICFront')
                      : null,
                  isCompleted: registrationProvider.nicFrontUrl != null,
                  isLoading: _isNicFrontLoading,
                ),
                SizedBox(height: height * 0.02),

                UploadButtonCustomized(
                  label: 'Upload NIC Back',
                  onPressed: registrationProvider.isBiodataComplete
                      ? () => _handleUpload('NICBack')
                      : null,
                  isCompleted: registrationProvider.nicBackUrl != null,
                  isLoading: _isNicBackLoading,
                ),
                SizedBox(height: height * 0.04),

                _buildInfoText(),
                SizedBox(height: height * 0.06),

                CustomButton(
                  text: 'Next',
                  backgroundColor: registrationProvider.isReadyForNext
                      ? primaryColor
                      : primaryColorLight,
                  textColor: blackPrimary,
                  onPressed: () {
                    if (!registrationProvider.isReadyForNext) {
                      return;
                    } 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmailOTPSignupScreen(),
                      ),
                    );
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

 Widget _buildStepButton({
  required String text,
  required bool isCompleted,
  required VoidCallback onPressed,
}) {
  final Color borderColor = isCompleted ? Colors.green : Colors.transparent;
  final Color bgColor = isCompleted ? Colors.green : blackPrimary;
  final Color textColor = isCompleted ? Colors.white : Colors.white;

  return ElevatedButton(
    onPressed: isCompleted ? null : onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: textColor,
      minimumSize: const Size(double.infinity, 54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor), // match upload button outline
      ),
      disabledBackgroundColor:
          isCompleted ? Colors.green.withOpacity(0.7) : Colors.grey.withOpacity(0.1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.edit,
          color: textColor,
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: textColor)),
      ],
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
              style:
                  TextStyle(color: blackPrimary, fontWeight: FontWeight.bold),
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
