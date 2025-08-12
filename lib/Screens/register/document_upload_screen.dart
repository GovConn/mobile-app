// screens/document_upload_screen.dart
import 'package:flutter/material.dart';
import '../../Components/upload_button_2.dart';
import '../Appointment/pending_screen.dart';


class DocumentUploadScreen extends StatefulWidget {
  final String serviceName;
  const DocumentUploadScreen({super.key, required this.serviceName});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  // This list would be dynamic based on the selected service
  final List<String> _requiredDocuments = [
    'Business registration certificate',
    'NIC copies of owners/directors',
    'Bank account statement',
    'Payment receipt (bank or online)',
  ];

  // Map to store the URLs of uploaded documents
  final Map<String, String?> _uploadedDocumentUrls = {};

  bool get _allDocumentsUploaded => _requiredDocuments.every(
      (doc) => _uploadedDocumentUrls[doc] != null && _uploadedDocumentUrls[doc]!.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.serviceName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Upload Required Documents',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: _requiredDocuments.length,
                itemBuilder: (context, index) {
                  final docName = _requiredDocuments[index];
                  return UploadButtonCustomized(
                    label: docName,
                    isCompleted: _uploadedDocumentUrls[docName] != null,
                    onPressed: (){

                    },
                    isLoading: false,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _allDocumentsUploaded
                    ? () {
                        // Here you would submit the _uploadedDocumentUrls map to your final API endpoint
                        print("All documents uploaded: $_uploadedDocumentUrls");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const PendingScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    : null, // Button is disabled if not all documents are uploaded
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700,
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}