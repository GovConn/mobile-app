import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/Appointment/pending_screen.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';
import '../../providers/appointment_provider.dart';
import '../../providers/auth_provider.dart';
import 'package:intl/intl.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final requestBody = appointmentProvider.slotRequestBody;

    // Extract values
    final bookingDate = requestBody?["booking_date"];
    final startTime = requestBody?["start_time"];
    final endTime = requestBody?["end_time"];
    final service = appointmentProvider.selectedService?.serviceNameEn ?? "N/A";
    final office = appointmentProvider.selectedOffice?.nameEn ?? "N/A";
    final username = authProvider.user?.firstName ?? "Guest";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: whitePrimary,
        surfaceTintColor: whitePrimary,
        elevation: 0,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              'Back',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirmation',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please review your appointment details before confirming.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  // Username
                  _buildConfirmationItem(
                    Icons.person,
                    'Username',
                    username,
                  ),

                  // Booking Date
                  _buildConfirmationItem(
                    Icons.calendar_today,
                    'Booking Date',
                    DateFormat('MMMM dd, yyyy')
                        .format(DateTime.parse(bookingDate)),
                  ),

                  // Service
                  _buildConfirmationItem(
                    Icons.local_hospital,
                    'Service',
                    service,
                  ),

                  // Office Details
                  _buildConfirmationItem(
                    Icons.location_on,
                    'Office',
                    office,
                  ),

                  // Time Slot
                  _buildConfirmationItem(
                    Icons.access_time,
                    'Time Slot',
                    '$startTime - $endTime',
                  ),
                ],
              ),
            ),
          ),

          // Fixed button at bottom
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final appointmentProvider =
                      Provider.of<AppointmentProvider>(context, listen: false);
                  final authProvider = Provider.of<AuthProvider>(context,listen: false);
                  await authProvider.fetchUser();
                  final citizenNic = authProvider.user?.nic; 
                  final slotId = appointmentProvider.selectedSlot!.slotId;

                  final success = await appointmentProvider.createAppointment(
                      citizenNic!, slotId);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Appointment created successfully")),
                    );
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PendingScreen()),
                  );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Failed to create appointment")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  'Confirm Appointment',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationItem(IconData icon, String title, String value) {
    return Card(
      color: lightGreyColor.withOpacity(0.25),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber[700], size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
