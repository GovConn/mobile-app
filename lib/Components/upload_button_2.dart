// lib/widgets/upload_button_customized.dart

import 'package:flutter/material.dart';
import 'package:gov_connect_app/theme/color_theme.dart'; // Assuming your color theme file path

class UploadButtonCustomized extends StatelessWidget {
  const UploadButtonCustomized({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isCompleted,
    required this.isLoading,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isCompleted;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    final bool isEnabled = !isCompleted && !isLoading;
    final Color borderColor = isCompleted ? Colors.green : greyTextColor;
    final Color contentColor = isCompleted ? Colors.white : greyTextColor;
    final IconData icon = isCompleted ? Icons.check_circle : Icons.upload_file;
    final Color disabledBgColor = isCompleted 
        ? Colors.green.withOpacity(0.7) 
        : Colors.grey.withOpacity(0.1);

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.transparent,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        disabledBackgroundColor: disabledBgColor,
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor), 
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: contentColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(color: contentColor),
                ),
              ],
            ),
    );
  }
}
