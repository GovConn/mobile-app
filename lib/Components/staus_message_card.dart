import 'package:flutter/material.dart';

class StatusMessageCard extends StatelessWidget {
  final String title;
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const StatusMessageCard({
    Key? key,
    required this.title,
    required this.message,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: backgroundColor ?? Colors.grey[200], // Default light grey
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: textColor ?? Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
