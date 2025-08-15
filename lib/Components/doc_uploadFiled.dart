import 'package:flutter/material.dart';
import 'package:gov_connect_app/Components/upload_button.dart';

import '../theme/color_theme.dart';

class DocumentUploadField extends StatefulWidget {
  final String documentName;
  final VoidCallback onUploadPressed;
  final bool isChecked; // Current status of the document (uploaded/checked)
  final ValueChanged<bool?> onCheckboxChanged; // Callback when checkbox changes

  const DocumentUploadField({
    Key? key,
    required this.documentName,
    required this.onUploadPressed,
    required this.isChecked,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<DocumentUploadField> createState() => _DocumentUploadFieldState();
}

class _DocumentUploadFieldState extends State<DocumentUploadField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Checkbox to indicate status
          Checkbox(
            value: widget.isChecked,
            onChanged: widget.onCheckboxChanged,
            activeColor: primaryColor, // Use your primary color
          ),
          // Expanded to allow the UploadButton to take available space
          Expanded(
            child: UploadButton(
              label: widget.documentName, // Document name as button label
              // Callback for upload action
            ),
          ),
        ],
      ),
    );
  }
}
