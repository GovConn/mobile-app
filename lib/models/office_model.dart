import 'dart:convert';

class Office {
  final int id;
  final String email;
  final String username;
  final String location;
  final int categoryId;
  final String nameSi;
  final String nameEn;
  final String nameTa;
  final String role;
  final String descriptionSi;
  final String descriptionEn;
  final String descriptionTa;
  final DateTime createdAt;

  Office({
    required this.id,
    required this.email,
    required this.username,
    required this.location,
    required this.categoryId,
    required this.nameSi,
    required this.nameEn,
    required this.nameTa,
    required this.role,
    required this.descriptionSi,
    required this.descriptionEn,
    required this.descriptionTa,
    required this.createdAt,
  });

  factory Office.fromMap(Map<String, dynamic> map) {
    return Office(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      location: map['location'] ?? '',
      categoryId: map['category_id']?.toInt() ?? 0,
      nameSi: map['name_si'] ?? '',
      nameEn: map['name_en'] ?? '',
      nameTa: map['name_ta'] ?? '',
      role: map['role'] ?? '',
      descriptionSi: map['description_si'] ?? '',
      descriptionEn: map['description_en'] ?? '',
      descriptionTa: map['description_ta'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  factory Office.fromJson(String source) =>
      Office.fromMap(json.decode(source));
}
