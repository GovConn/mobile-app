import 'dart:convert';

List<Service> serviceFromJson(String str) =>
    List<Service>.from(json.decode(str).map((x) => Service.fromJson(x)));

class Service {
  final int id;
  final String categorySi;
  final String categoryEn;
  final String categoryTa;
  final String descriptionSi;
  final String descriptionEn;
  final String descriptionTa;
  final DateTime createdAt;

  Service({
    required this.id,
    required this.categorySi,
    required this.categoryEn,
    required this.categoryTa,
    required this.descriptionSi,
    required this.descriptionEn,
    required this.descriptionTa,
    required this.createdAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        categorySi: json["category_si"],
        categoryEn: json["category_en"],
        categoryTa: json["category_ta"],
        descriptionSi: json["description_si"],
        descriptionEn: json["description_en"],
        descriptionTa: json["description_ta"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}