class UploadResponse {
  final String filename;
  final DateTime uploadedAt;
  final String url;

  UploadResponse({
    required this.filename,
    required this.uploadedAt,
    required this.url,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      filename: json['filename'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
      url: json['url'],
    );
  }
}

