import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gov_connect_app/base_url.dart';
import 'package:gov_connect_app/models/citizen_reg_model.dart';
import 'package:http/http.dart' as http;

class RegisterApiService {
  Future<CitizenRegistrationResponse> registerCitizen(CitizenRegistrationRequest data) async {
     debugPrint(data.toJson().toString());
    final response = await http.post(
      Uri.parse('$BASE_URL/api/v1/citizen/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data.toJson()),
    );
   
    if (response.statusCode == 200 || response.statusCode == 201) {
      return CitizenRegistrationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register citizen. Status code: ${response.statusCode}');
    }
  }
}