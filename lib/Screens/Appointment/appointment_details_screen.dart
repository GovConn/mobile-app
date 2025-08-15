// lib/screens/appointment_details_screen.dart
import 'package:flutter/material.dart';
import 'package:gov_connect_app/Screens/Appointment/appointment_doc_upload_screen.dart';
import 'package:gov_connect_app/Screens/Appointment/resrevation_screen.dart';
import 'package:gov_connect_app/providers/appointment_provider.dart';
import 'package:gov_connect_app/theme/color_theme.dart';
import 'package:provider/provider.dart';

import '../../models/office_model.dart';
import '../../models/office_service_model.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final int categoryId;
  const AppointmentDetailsScreen({super.key, required this.categoryId});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(context, listen: false)
          .getOffices(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Back',
            style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<AppointmentProvider>(
          builder: (context, appointmentProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Appointments',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 32),

                // Location Dropdown
                _buildOfficeDropdown(appointmentProvider),
                const SizedBox(height: 24),

                // Purpose Dropdown
                _buildServiceDropdown(appointmentProvider),
                const SizedBox(height: 24),

                const Text(
                  'Important Instructions Before Booking',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                _buildInstructionItem('1',
                    'You need to change your default password to a more secure one.'),
                _buildInstructionItem('2',
                    'Keep this password secured and do not share it with anyone.'),
                _buildInstructionItem(
                    '3', 'Bring all necessary documents to your appointment.'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (appointmentProvider.selectedOffice != null &&
                            appointmentProvider.selectedService != null)
                        ? () {
                            final service =
                                appointmentProvider.selectedService!;

                            if (service.requiredDocumentTypes.isEmpty) {
                              // No required documents → go directly to Reservation screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ReservationScreen(),
                                ),
                              );
                            } else {
                              // Documents required → go to Document Upload screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AppointmentDocUplaodScreen(),
                                ),
                              );
                            }
                          }
                        : null, // Disabled if no selections
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOfficeDropdown(AppointmentProvider provider) {
    if (provider.officeState == NotifierState.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.officeState == NotifierState.error) {
      return Center(child: Text('Error: ${provider.errorMessage}'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select office location',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Office>(
              value: provider.selectedOffice,
              hint: const Text('Select an Office'),
              isExpanded: true,
              items: provider.offices.map((office) {
                return DropdownMenuItem<Office>(
                  value: office,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(office.nameEn),
                    subtitle: Text(
                        '${office.descriptionEn} - ${office.location}',
                        style: TextStyle(color: Colors.grey[600])),
                  ),
                );
              }).toList(),
              onChanged: (Office? newValue) {
                provider.selectOffice(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDropdown(AppointmentProvider provider) {
    bool isOfficeSelected = provider.selectedOffice != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select purpose',
            style: TextStyle(
                color: isOfficeSelected ? Colors.grey[600] : Colors.grey[400])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(8),
            color: isOfficeSelected ? Colors.transparent : Colors.grey.shade200,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<GovService>(
              value: provider.selectedService,
              hint: Text(isOfficeSelected
                  ? 'Select a Service'
                  : 'Select an office first'),
              isExpanded: true,
              items: provider.services.map((service) {
                return DropdownMenuItem<GovService>(
                  value: service,
                  child: Text(service.serviceNameEn,
                      style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
              // Disable dropdown if no office is selected
              onChanged: isOfficeSelected
                  ? (GovService? newValue) {
                      provider.selectService(newValue);
                    }
                  : null,
            ),
          ),
        ),
        if (provider.serviceState == NotifierState.loading)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildInstructionItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
