import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

// Enum to define the possible statuses of an appointment
enum AppointmentStatus {
  accepted,
  reschedule,
  rejected,
  pending,
  rated // A status for after the user has rated the service
}

// Data model to hold all the details of an appointment
class AppointmentDetails {
  final AppointmentStatus status;
  final String instructions;
  final String office;
  final String purpose;
  final String date;
  final String time;
  final String? newTime; // Optional: for reschedule status
  final String? acceptBefore; // Optional: for reschedule status

  AppointmentDetails({
    required this.status,
    required this.instructions,
    required this.office,
    required this.purpose,
    required this.date,
    required this.time,
    this.newTime,
    this.acceptBefore,
  });
}

class AppointmentStatusScreen extends StatelessWidget {
  final AppointmentDetails details;

  const AppointmentStatusScreen({super.key, required this.details});

  // --- Helper methods to get UI elements based on status ---

  Color _getStatusColor() {
    switch (details.status) {
      case AppointmentStatus.accepted:
      case AppointmentStatus.rated:
        return Colors.green.withOpacity(0.8);
      case AppointmentStatus.reschedule:
        return Colors.amber.withOpacity(0.8);
      case AppointmentStatus.rejected:
        return Colors.red.withOpacity(0.8);
      case AppointmentStatus.pending:
      default:
        return lightGreyColor;
    }
  }

  String _getStatusTitle() {
    switch (details.status) {
      case AppointmentStatus.accepted:
      case AppointmentStatus.rated:
        return 'Accepted';
      case AppointmentStatus.reschedule:
        return 'Reschedule';
      case AppointmentStatus.rejected:
        return 'Rejected';
      case AppointmentStatus.pending:
        return 'Pending';
    }
  }

  String _getStatusMessage() {
    switch (details.status) {
      case AppointmentStatus.accepted:
      case AppointmentStatus.rated:
        return 'You can now come to the office. Be sure to not miss the appointed time';
      case AppointmentStatus.reschedule:
        return 'Due to unavoidable reasons, we have to move your appointment to new slot.';
      case AppointmentStatus.rejected:
        return 'Your appointment has been rejected.';
      case AppointmentStatus.pending:
        return 'Your request is still being processed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: blackPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('back', style: TextStyle(color: blackPrimary, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusCard(),
              const SizedBox(height: 24),
              _buildInstructionsSection(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 32),
              _buildDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets for different sections of the screen ---

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            _getStatusTitle(),
            style: const TextStyle(
              color: blackPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getStatusMessage(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: blackPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Instructions', style: TextStyle(color: greyTextColor)),
        const SizedBox(height: 8),
        if (details.status == AppointmentStatus.reschedule)
          _buildRescheduleInstructions()
        else
          Text(details.instructions, style: const TextStyle(color: blackPrimary, fontSize: 16)),
      ],
    );
  }

  Widget _buildRescheduleInstructions() {
    return Column(
      children: [
        _buildInstructionRow(details.date, isChanged: false),
        _buildInstructionRow(details.newTime!, isChanged: true),
        _buildInstructionRow('Accept before', value: details.acceptBefore!),
      ],
    );
  }

  Widget _buildInstructionRow(String label, {bool isChanged = false, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: blackPrimary, fontSize: 16)),
          if(value != null)
             Text(value, style: const TextStyle(color: blackPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          if(value == null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isChanged ? Colors.amber.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isChanged ? 'changed' : 'not changed',
                style: TextStyle(color: isChanged ? Colors.amber[200] : Colors.green[200], fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    switch (details.status) {
      case AppointmentStatus.accepted:
        return _buildButtonRow('Go Back', 'Rate Service', primaryIsBlack: true);
      case AppointmentStatus.reschedule:
        return _buildButtonRow('Accept', 'Rate Service', isPrimaryFilled: true);
      case AppointmentStatus.rejected:
        return _buildButtonRow('Re-apply', 'Rate Service', primaryIsBlack: true);
      case AppointmentStatus.pending:
        return _buildButtonRow('Cancle', 'Rate Service', isSecondaryDisabled: true, isPrimaryRed: true);
       case AppointmentStatus.rated:
        return _buildRatedButtonRow();
    }
  }

  Widget _buildButtonRow(String primaryText, String secondaryText, {bool isPrimaryFilled = false, bool isSecondaryDisabled = false, bool isPrimaryRed = false, bool primaryIsBlack = false}) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimaryFilled ? Colors.green : (isPrimaryRed ? Colors.red.withOpacity(0.8) : (primaryIsBlack ? Colors.black : Colors.transparent)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(primaryText ,style: const TextStyle(color: whitePrimary),),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: isSecondaryDisabled ? null : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[600],
              disabledBackgroundColor: lightGreyColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text(secondaryText, style: TextStyle(color: isSecondaryDisabled ? greyTextColor : Colors.black)),
          ),
        ),
      ],
    );
  }

   Widget _buildRatedButtonRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: lightGreyColor,
              disabledBackgroundColor: lightGreyColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: Text('Rated', style: TextStyle(color: blackPrimary)),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Selected local office', details.office),
        _buildDetailItem('Purpose', details.purpose),
        _buildDetailItem('Appointment Date', details.date),
        _buildDetailItem('Time', details.time),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: greyTextColor, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: blackPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Example of how to use the screen with different statuses
class AppointmentStatusExamples extends StatelessWidget {
  const AppointmentStatusExamples({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Create an instance of AppointmentDetails for each status ---

    // 1. ACCEPTED: The initial accepted state before rating.
    final acceptedDetails = AppointmentDetails(
      status: AppointmentStatus.accepted,
      instructions: 'None',
      office: 'Divisional Secretariat - Kaduwela',
      purpose: 'Requesting copies of birth certificates',
      date: '2025 - August - 25',
      time: '9.15 AM - 9.30 AM',
    );
    
    // 2. RESCHEDULE: When the office proposes a new time.
    final rescheduleDetails = AppointmentDetails(
      status: AppointmentStatus.reschedule,
      instructions: '', // Instructions are built dynamically for this status
      office: 'Divisional Secretariat - Kaduwela',
      purpose: 'Requesting copies of birth certificates',
      date: '2025 - August - 25',
      time: '9.15 AM - 9.30 AM',
      newTime: '10.15 AM - 10.30 AM',
      acceptBefore: 'XX : XX : XX',
    );

    // 3. REJECTED: When the appointment request is rejected.
    final rejectedDetails = AppointmentDetails(
      status: AppointmentStatus.rejected,
      instructions: 'Reason from the office: Provided documents are not clear.',
      office: 'Divisional Secretariat - Kaduwela',
      purpose: 'Requesting copies of birth certificates',
      date: '2025 - August - 25',
      time: '9.15 AM - 9.30 AM',
    );

    // 4. PENDING: While the request is being processed.
    final pendingDetails = AppointmentDetails(
      status: AppointmentStatus.pending,
      instructions: 'None',
      office: 'Divisional Secretariat - Kaduwela',
      purpose: 'Requesting copies of birth certificates',
      date: '2025 - August - 25',
      time: '9.15 AM - 9.30 AM',
    );

    // 5. RATED: The final state after an accepted appointment has been rated.
    final ratedDetails = AppointmentDetails(
      status: AppointmentStatus.rated,
      instructions: 'None',
      office: 'Divisional Secretariat - Kaduwela',
      purpose: 'Requesting copies of birth certificates',
      date: '2025 - August - 25',
      time: '9.15 AM - 9.30 AM',
    );
    
    // --- To use one of them, just pass the corresponding details object ---
    // --- UNCOMMENT the line for the status you want to preview ---
    
    // return AppointmentStatusScreen(details: acceptedDetails);
    // return AppointmentStatusScreen(details: rescheduleDetails);
    // return AppointmentStatusScreen(details: rejectedDetails);
     return AppointmentStatusScreen(details: acceptedDetails);
    // return AppointmentStatusScreen(details: ratedDetails);
  }
}
