import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

class AppointmentServicesScreen extends StatelessWidget {
  const AppointmentServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('back', style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Appointments',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 32),
            _buildServiceCard(
              context,
              icon: Icons.local_hospital,
              title: 'Hospital Services',
              subtitle: 'Why choose this office with popular services from this place.',
            ),
            _buildServiceCard(
              context,
              icon: Icons.account_balance,
              title: 'Municipal Council',
              subtitle: 'Why choose this office with popular services from this place.',
            ),
            _buildServiceCard(
              context,
              icon: Icons.description,
              title: 'Examination Services',
              subtitle: 'Why choose this office with popular services from this place.',
            ),
            _buildServiceCard(
              context,
              icon: Icons.airplanemode_active,
              title: 'Passport Services',
              subtitle: 'Why choose this office with popular services from this place.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.help_outline, color: blackPrimary),
                label: const Text(
                  'Help Me Find the Right Office',
                  style: TextStyle(color: blackPrimary),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: primaryColor),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 0,
      color: lightGreyColor.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: greyTextColor.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber[700], size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}