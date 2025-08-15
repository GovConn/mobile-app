// lib/models/gov_service.dart
import 'dart:convert';

class GovService {
  final int serviceId;
  final int govNodeId;
  final String serviceType;
  final String serviceNameSi;
  final String serviceNameEn;
  final String serviceNameTa;
  final String descriptionSi;
  final String descriptionEn;
  final String descriptionTa;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final List<int> requiredDocumentTypes;

  GovService({
    required this.serviceId,
    required this.govNodeId,
    required this.serviceType,
    required this.serviceNameSi,
    required this.serviceNameEn,
    required this.serviceNameTa,
    required this.descriptionSi,
    required this.descriptionEn,
    required this.descriptionTa,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.requiredDocumentTypes,
  });

  factory GovService.fromMap(Map<String, dynamic> map) {
    return GovService(
      serviceId: map['service_id']?.toInt() ?? 0,
      govNodeId: map['gov_node_id']?.toInt() ?? 0,
      serviceType: map['service_type'] ?? '',
      serviceNameSi: map['service_name_si'] ?? '',
      serviceNameEn: map['service_name_en'] ?? '',
      serviceNameTa: map['service_name_ta'] ?? '',
      descriptionSi: map['description_si'] ?? '',
      descriptionEn: map['description_en'] ?? '',
      descriptionTa: map['description_ta'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
      isActive: map['is_active'] ?? false,
      requiredDocumentTypes: List<int>.from(map['required_document_types'] ?? []),
    );
  }

  factory GovService.fromJson(String source) =>
      GovService.fromMap(json.decode(source));
}
