import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/upload_button.dart';
import 'package:gov_connect_app/templates/qr_screen_template.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

import '../../Components/detail_card.dart';
import '../../Components/doc_uploadFiled.dart';
import '../../Components/searchBarField.dart';
import '../../Components/staus_message_card.dart';

class ConformAppointmentScreen extends StatefulWidget {
  const ConformAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ConformAppointmentScreen> createState() =>
      _ConformAppointmentScreenState();
}

class _ConformAppointmentScreenState extends State<ConformAppointmentScreen> {
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
                'Confirmation',
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
          SizedBox(height: height * 0.01),
          DetailCard(
            iconData:
                Icons.people_alt, // Or a custom icon representing municipality
            title: 'Municipal Council',
            subtitle:
                'Why choose this office with popular services from this place.',
            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.005),
          DetailCard(
            iconData: Icons
                .location_pin, // Or a custom icon representing municipality
            title: 'Karapitiya Teaching Hospital',

            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.005),
          DetailCard(
            iconData: Icons
                .check_circle_outline_rounded, // Or a custom icon representing municipality
            title: 'Doctor Channeling',
            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.005),
          DetailCard(
            iconData: Icons
                .date_range_outlined, // Or a custom icon representing municipality
            title: 'August 9, 2025',

            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.005),
          DetailCard(
            iconData: Icons
                .access_time_rounded, // Or a custom icon representing municipality
            title: '16:30 P.M',

            onTap: () {
              print('Municipal Council card tapped!');
              // Navigate to details or select this office
            },
          ),
          SizedBox(height: height * 0.04),
        ],
      ),

      actionButtonText:
          'Confirm Appointment', // Text for the bottom action button
      onActionButtonPressed: () {
        // Handle action button press
        print('Action button pressed!');
      },
      customButtonColor: primaryColor, // Use your primary color
      textColor: blackPrimary, // Text color for the action button
    );
  }
}
