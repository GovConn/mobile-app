// lib/services/api_service.dart
import 'dart:convert';
import 'package:gov_connect_app/base_url.dart';
import 'package:gov_connect_app/models/office_model.dart';
import 'package:http/http.dart' as http;

import '../models/office_service_model.dart';

class OfficeAPiService {
  Future<List<Office>> fetchOffices(int categoryId) async {
    final response = await http.get(Uri.parse('$BASE_URL/api/v1/gov/offices?category_id=$categoryId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Office> offices = body.map((dynamic item) => Office.fromMap(item)).toList();
      return offices;
    } else {
      throw Exception('Failed to load offices');
    }
  }

  Future<List<GovService>> fetchServices(int officeId) async {
    final response = await http.get(Uri.parse('$BASE_URL/api/v1/gov/services/$officeId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<GovService> services = body.map((dynamic item) => GovService.fromMap(item)).toList();
      return services;
    } else {
      throw Exception('Failed to load services');
    }
  }
}