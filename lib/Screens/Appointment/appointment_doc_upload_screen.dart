import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/Appointment/resrevation_screen.dart';

class AppointmentDocUplaodScreen extends StatefulWidget {
  const AppointmentDocUplaodScreen({super.key});

  @override
  State<AppointmentDocUplaodScreen> createState() => _AppointmentDocUplaodScreenState();
}

class _AppointmentDocUplaodScreenState extends State<AppointmentDocUplaodScreen> {
  // State variables to track checkbox states
  final Map<String, bool> _documentChecks = {
    'Business registration certificate.': false,
    'NIC copies of owner/directors': false,
    'Bank account statement.': false,
    'Payment receipt (bank or online)': false,
  };

  bool _confirmValid = false;
  bool _confirmComply = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Back Button ---
                  const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'back',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Header Text ---
                  const Text(
                    'Business Income Tax\nRegistration',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Upload Section Header ---
                  const Text(
                    'Upload Required Documents',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const Divider(color: Colors.black12, height: 8),
                  const SizedBox(height: 20),

                  // --- Step 1 Information ---
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 20,
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Submit Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'You need to provide required information and valid documents.',
                              style: TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Document Upload List ---
                  _buildDocumentUploadItem('Business registration certificate.'),
                  _buildDocumentUploadItem('NIC copies of owner/directors'),
                  _buildDocumentUploadItem('Bank account statement.'),
                  _buildDocumentUploadItem('Payment receipt (bank or online)'),
                  const SizedBox(height: 24),

                  // --- Select Office Locations Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // This button appears disabled in the UI
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Select Office Locations'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Confirmation Checkboxes ---
                  _buildConfirmationCheckbox(
                    value: _confirmValid,
                    onChanged: (val) => setState(() => _confirmValid = val!),
                    label: 'I here by confirm all documents are valid',
                  ),
                  _buildConfirmationCheckbox(
                    value: _confirmComply,
                    onChanged: (val) => setState(() => _confirmComply = val!),
                    label: 'I here by confirm that I will comply and provide any missing details to finish this process if needed in the future.',
                  ),
                  const SizedBox(height: 24),

                  // --- Submit Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReservationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Helper widget to build each document upload row
  Widget _buildDocumentUploadItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: _documentChecks[title],
            onChanged: (bool? value) {
              setState(() {
                _documentChecks[title] = value!;
              });
            },
            activeColor: Colors.orange,
            checkColor: Colors.white,
            side: BorderSide(color: Colors.grey.shade400),
          ),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Handle file upload
              },
              icon: const Icon(Icons.upload_file, color: Colors.black54),
              label: Text(
                title,
                style: const TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build each confirmation checkbox row
  Widget _buildConfirmationCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String label,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange,
            checkColor: Colors.white,
             side: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              label,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}