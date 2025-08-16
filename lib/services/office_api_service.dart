// lib/services/api_service.dart
import 'dart:convert';
import 'package:gov_connect_app/base_url.dart';
import 'package:gov_connect_app/models/appointment_slot_model.dart';
import 'package:gov_connect_app/models/office_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

  Future<List<AppointmentSlot>> fetchAvailableSlots(
    int reservationId, DateTime date) async {
  final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  final response = await http.get(Uri.parse(
      '$BASE_URL/api/v1/appointments/available_slots/$reservationId/$formattedDate'));

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<AppointmentSlot> slots = body
        .map((dynamic item) => AppointmentSlot.fromMap(item))
        .toList();
    return slots;
  } else if (response.statusCode == 404) {
    try {
      final errorResponse = json.decode(response.body);
      if (errorResponse['detail'] == 'No available slots found') {
        return []; // Return empty list for "no slots" case
      }
      throw Exception(errorResponse['detail'] ?? 'No slots available');
    } catch (e) {
      return []; 
    }
  } else {
    try {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['detail'] ?? 'Failed to load available slots';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Failed to load available slots');
    }
  }
}

Future<bool> createAppointment(String citizenNic, int slotId) async {
  final url = Uri.parse('$BASE_URL/api/v1/appointments/reserved_user');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "citizen_nic": citizenNic,
        "slot_id": slotId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}

}