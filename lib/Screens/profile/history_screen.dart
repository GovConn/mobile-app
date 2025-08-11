import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart';

class HistoryItem {
  final String title;
  final String date;
  final int rating;
  final bool isCompleted;

  HistoryItem({
    required this.title,
    required this.date,
    required this.rating,
    required this.isCompleted,
  });
}

class HistoryScreen extends StatelessWidget {
   HistoryScreen({super.key});

  final List<HistoryItem> historyItems =  [
    HistoryItem(
      title: 'Appointment',
      date: '2025-August-15',
      rating: 4,
      isCompleted: true,
    ),
    HistoryItem(
      title: 'Appointment',
      date: '2025-August-05',
      rating: 3,
      isCompleted: true,
    ),
  ];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 24.0),
              child: Text(
                'History',
                style: TextStyle(color: blackPrimary, fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  return _buildHistoryCard(historyItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(HistoryItem item) {
    return Card(
      color: lightGreyColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(color: blackPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.date,
                    style: const TextStyle(color: greyTextColor, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < item.rating ? Icons.star : Icons.star_border,
                          color: primaryColor,
                          size: 18,
                        );
                      }),
                      const SizedBox(width: 8),
                      const Text(
                        'Rate the Service',
                        style: TextStyle(color: greyTextColor, fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}