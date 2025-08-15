import 'package:flutter/material.dart';

import '../Components/custom_button.dart';
import '../theme/color_theme.dart';

class QrScreenTemplate extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onBackButtonPressed;
  final String? actionButtonText;
  final VoidCallback? onActionButtonPressed;
  final Widget? bottomWidget; // For adding custom widgets at the bottom
  final Color? scaffoldBackgroundColor; // New property for background color
  final Color? customButtonColor;
  final Color? textColor;

  const QrScreenTemplate({
    Key? key,
    required this.title,
    required this.content,
    this.onBackButtonPressed,
    this.actionButtonText,
    this.onActionButtonPressed,
    this.bottomWidget,
    this.scaffoldBackgroundColor,
    this.customButtonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor ??
          Colors.white, // Use new property or default
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('back',
            style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // or to allow it to take available space
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: onBackButtonPressed != null
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            // The main content area, flexible
            Expanded(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
            // Action button and optional bottom widget
            if (actionButtonText != null && onActionButtonPressed != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: CustomButton(
                    // Changed from PrimaryButton to CustomButton
                    text: actionButtonText!,
                    onPressed: onActionButtonPressed!,
                    backgroundColor: customButtonColor ?? primaryColor,
                    textColor: textColor ?? Colors.white,
                  ),
                ),
              ),
            if (bottomWidget != null) bottomWidget!,
          ],
        ),
      ),
    );
  }
}
