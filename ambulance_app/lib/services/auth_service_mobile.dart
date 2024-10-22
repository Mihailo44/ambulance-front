// lib/services/auth_service_mobile.dart
import 'dart:convert';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/basic_user_info.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/auth');
    var client = http.Client();  // Using http.Client for mobile/desktop
    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        final accessToken = responseBody['access_token'] ?? '';
        final accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        final basicUser = BasicUserInfo.fromJson(responseBody["user"]);
        basicUser?.accessToken = accessToken;
      }
    } catch (error) {
      throw error;
    }
  }

  // Future<void> refreshTokens() async {
  //   final url = Uri.parse('$apiUrl/refresh-tokens');
  //   var client = http.Client();
  //   try {
  //     final response = await client.post(
  //       url,
  //       headers: {'Authorization': 'Bearer $accessToken'},
  //     );

  //     if (response.statusCode == 200) {
  //       final responseBody = json.decode(response.body);
  //       accessToken = responseBody['access_token'] ?? '';
  //       basicUser?.accessToken = accessToken;
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // void logout() async {
  //   final url = Uri.parse('$apiUrl/logout');
  //   var client = http.Client();
  //   try {
  //     final response = await client.post(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       accessToken = '';
  //       basicUser = null;
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
