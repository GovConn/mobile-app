import 'package:flutter/material.dart';

class DocumentUploadField extends StatefulWidget {
  final String documentName;
  final VoidCallback onUploadPressed;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;

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
          Checkbox(
            value: widget.isChecked,
            onChanged: widget.onCheckboxChanged,
            activeColor: Colors.blue,
          ),
          Expanded(
            child: GestureDetector(
              onTap: widget.onUploadPressed,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.upload_file, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.documentName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
