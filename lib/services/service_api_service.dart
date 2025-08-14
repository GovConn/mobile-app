import 'package:gov_connect_app/base_url.dart';
import 'package:gov_connect_app/models/service_model.dart';
import 'package:http/http.dart' as http;

class ServiceApiService {
  static const String _baseUrl = "$BASE_URL/api/v1"; 

 Future<List<Service>> fetchServices(String token) async  { 

    final response = await http.get(
      Uri.parse('$_baseUrl/gov/services/'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return serviceFromJson(response.body);
    } else {
      throw Exception('Failed to load services. Status Code: ${response.statusCode}');
    }
  }
}