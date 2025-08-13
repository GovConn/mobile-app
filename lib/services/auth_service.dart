import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gov_connect_app/base_url.dart';
import 'package:gov_connect_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _baseUrl = "$BASE_URL/api/v1/citizen/login";

  final _storage = const FlutterSecureStorage();
  final String _tokenKey = 'access_token';

  Future<UserModel> login(String nic, String password) async {
    final url = Uri.parse(_baseUrl);

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'username': nic,
      'password': password,
    };

    debugPrint(body.toString());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final user = UserModel.fromJson(responseBody);

        await _storage.write(key: _tokenKey, value: user.accessToken);

        return user;
      } else {
        final errorBody = json.decode(response.body);
        debugPrint(response.statusCode.toString());
        debugPrint(
            'Login failed: ${errorBody['detail'] ?? response.reasonPhrase}');
        throw Exception(
            'Failed to login: ${errorBody['detail'] ?? response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Method to check if a token exists, indicating an active session
  Future<bool> hasToken() async {
    String? token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }
}
