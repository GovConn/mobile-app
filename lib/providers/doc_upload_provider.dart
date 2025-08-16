// lib/providers/doc_upload_provider.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../services/doc_upload_service.dart'; // Adjust path if needed

enum UploadStatus { initial, uploading, success, error }

class DocUploadProvider with ChangeNotifier {
  final FileUploadService _uploadService = FileUploadService();

  UploadStatus _status = UploadStatus.initial;
  UploadStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _uploadedFileUrl;
  String? get uploadedFileUrl => _uploadedFileUrl;

  Future<String?> uploadDocument({
    required File file,
    required String docName,
    required String userNic, 
    required String userName, 
  }) async {
    _status = UploadStatus.uploading;
    _errorMessage = null;
    notifyListeners();

    try {
      final url = await _uploadService.uploadFile(
        file: file,
        nicNo: userNic,
        name: userName,
        docName: docName,
      );

      _uploadedFileUrl = url;
      _status = UploadStatus.success;
      notifyListeners();
      return url;
    } catch (e) {
      _status = UploadStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }
}