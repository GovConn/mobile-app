import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/upload_button.dart';
import 'package:gov_connect_app/templates/qr_screen_template.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/detail_card.dart';
import '../../Components/doc_uploadFiled.dart';
import '../../Components/searchBarField.dart';
import '../../Components/staus_message_card.dart';

class PlaceAppointmentScreen extends StatefulWidget {
  const PlaceAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<PlaceAppointmentScreen> createState() => _PlaceAppointmentScreenState();
}

class _PlaceAppointmentScreenState extends State<PlaceAppointmentScreen> {
  bool isUploaded = false;

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
          DetailCard(
            iconData:
                Icons.people, // Or a custom icon representing municipality
            title: 'Municipal Council',
            subtitle:
                'Why choose this office with popular services from this place.',
            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.02),
          SearchBarField(
            hintText: 'Select Place',
            onTap: () {
              print('Select Place search bar tapped!');
              // Open a location picker or search results
            },
          ),
          SizedBox(height: height * 0.04),
        ],
      ),

      actionButtonText:
          'Select Date & Time', // Text for the bottom action button
      onActionButtonPressed: () {
        // Handle action button press
        print('Action button pressed!');
      },
      customButtonColor: primaryColor, // Use your primary color
      textColor: blackPrimary, // Text color for the action button
    );
  }
}
