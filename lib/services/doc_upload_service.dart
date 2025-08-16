import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gov_connect_app/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/doc_upload_model.dart';

class FileUploadService {
  static const String _baseUrl = "$BASE_URL/api/v1"; 

  Future<String> uploadFile({
    required File file,
    required String nicNo,
    required String name,
    required String docName,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/blob/upload');
      final fileBytes = await file.readAsBytes();
      final base64File = base64Encode(fileBytes);
      final fileExtension = path.extension(file.path).replaceAll('.', '');

      final filename = '${nicNo}_$docName';

      final requestBody = jsonEncode({
        "content_type": fileExtension,
        "file": base64File,
        "filename": filename,
      });

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final uploadResponse = UploadResponse.fromJson(responseData);
        return uploadResponse.url;
      } else {
        throw Exception('Failed to upload file. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }
}
