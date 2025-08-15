import 'package:flutter/material.dart';
import 'package:gov_connect_app/templates/qr_screen_template.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/staus_message_card.dart';

class UploadedScreen extends StatelessWidget {
  const UploadedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrScreenTemplate(
      title: 'Business Income Tax\nRegistration', // Title from your image
      onBackButtonPressed: () {
        // Handle back button press, e.g., Navigator.pop(context);
        print('Back button pressed');
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'More Details',
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
          const SizedBox(height: 20),
          // Placeholder for QR code
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.qr_code, size: 150, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const Text(
            'Reference Number',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'XXXX XXXX XXXX XXXX',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 30),
          StatusMessageCard(
            title: 'Need Action',
            message:
                'The document X require more recently validated copy submitted.',
            backgroundColor: warningPrimary, // Adjust color to match your image
            textColor: blackPrimary,
          ),
          const SizedBox(height: 20), // Spacing before the action button
        ],
      ),
      actionButtonText: 'Upload', // Text for the bottom action button
      onActionButtonPressed: () {
        // Handle action button press
        print('Action button pressed!');
      },
      customButtonColor: Color(0xFFD4D4D4), // Use your primary color
      textColor: blackPrimary, // Text color for the action button
    );
  }
}
