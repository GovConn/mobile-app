import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/upload_button.dart';
import 'package:gov_connect_app/templates/qr_screen_template.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/doc_uploadFiled.dart';
import '../../Components/staus_message_card.dart';

class DocUploadScreen extends StatefulWidget {
  const DocUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocUploadScreen> createState() => _DocUploadScreenState();
}

class _DocUploadScreenState extends State<DocUploadScreen> {
  bool isUploaded = false;

  void _handleUpload() {
    print('Uploading file...');
    // Simulate a delay for upload
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isUploaded = true; // Show check mark after upload
      });
      print('Upload complete!');
    });
  }

  void _handleCheckboxChanged(bool? newValue) {
    setState(() {
      isUploaded = newValue ?? false;
    });
    print('Checkbox changed to: $isUploaded');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return QrScreenTemplate(
      title: 'Business Income Tax\nRegistration', // Title from your image
      onBackButtonPressed: () {
        // Handle back button press, e.g., Navigator.pop(context);
        print('Back button pressed');
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 28.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Provide Information',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: blackPrimary,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Colors.grey),
          ),
          SizedBox(height: height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal:
                    28.0), // Apply padding to the DocumentUploadField itself
            child: DocumentUploadField(
              documentName: 'Document x',
              isChecked: isUploaded,
              onCheckboxChanged: _handleCheckboxChanged,
              onUploadPressed: _handleUpload,
            ),
          ),
          SizedBox(height: height * 0.04),
        ],
      ),

      actionButtonText: 'Submit', // Text for the bottom action button
      onActionButtonPressed: () {
        // Handle action button press
        print('Action button pressed!');
      },
      customButtonColor: primaryColor, // Use your primary color
      textColor: blackPrimary, // Text color for the action button
    );
  }
}
