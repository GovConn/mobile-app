import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/custom_button.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _appExperienceRating = 0;
  int _staffExperienceRating = 0;
  int _officeExperienceRating = 0;

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
        title: const Text(
          'back',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rating the Service',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildNoticeCard(),
              const SizedBox(height: 24),
              _buildDetailsSection(),
              const SizedBox(height: 32),
              _buildRatingSection(
                'Experience with this app for this service',
                _appExperienceRating,
                (rating) {
                  setState(() {
                    _appExperienceRating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildRatingSection(
                'Experience with the staff',
                _staffExperienceRating,
                (rating) {
                  setState(() {
                    _staffExperienceRating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildRatingSection(
                'Experience with the government office',
                _officeExperienceRating,
                (rating) {
                  setState(() {
                    _officeExperienceRating = rating;
                  });
                },
              ),
              const SizedBox(height: 32),
              _buildCommentsField(),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Submit',
                backgroundColor: primaryColor,
                textColor: blackPrimary,
                onPressed: () {
                  // Handle submit action
                  // For example, you can show a success message or navigate to another screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rating submitted successfully!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: primaryColorLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Your honest feedback about this government service will help the government to audit and improve the quality of the service.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black87, height: 1.5, fontSize: 15),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Selected local office', 'Divisional Secretariat - Kaduwela'),
        _buildDetailItem('Purpose', 'Requesting copies of birth certificate'),
        _buildDetailItem('Appointment Date', '2025 - August - 25'),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRatingSection(String label, int currentRating, Function(int) onRatingUpdate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber[600],
                size: 32,
              ),
              onPressed: () {
                onRatingUpdate(index + 1);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCommentsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Comments',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.amber[700]!),
            ),
          ),
        ),
      ],
    );
  }

}
