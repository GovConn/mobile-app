import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.upload_file, color: greyTextColor),
      label: Text(
        label,
        style: const TextStyle(color: greyTextColor),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: greyTextColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
